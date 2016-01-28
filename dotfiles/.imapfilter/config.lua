-- Rules for filtering my inbox

options.subscribe = true

-- The mobile me account
icloud = IMAP {
    server = "imap.mail.me.com",
    username = "joshkunz@me.com",
    port = 993,
    ssl = "ssl3"
}

-- Repositories to not mark as read
WATCH_REPOS = { "flowops", "openaccess", "wafer", "openaccessman",
                "renquinn/atc-14" }
-- Name of the folder to store important commits in
IMPORTANT_FOLDER = "_commits"
-- Top level folder to store git emails in
GIT_FOLDER = "Repos"
REPO_MATCHER = "%[([^%c%]]*)%]"

-- Make sure the mailbox exists
icloud : create_mailbox(GIT_FOLDER)
icloud : create_mailbox(IMPORTANT_FOLDER)

table.contains = function (t, value)
    for _, v in pairs(t) do
        if v == value then return true end
    end
    -- If we don't find the value, return false
    return false
end

function handle_git () -- (or mercurial)
    local new_git_commits = icloud.INBOX : 
        is_unseen() : 
        --sent_since("01-Jan-2014") :
--        contain_to("flux.utah.edu") :
        --Also match mercurial commits
        match_subject("^(git)|(hg) commit:")

    local boxes = {}
    -- Sort the mail in to folders by repository
    for _, message in ipairs(new_git_commits) do
        -- Get the uid of the message
        local mailbox, uid = table.unpack(message)
        -- Get the repository this message pertains to
        _, _, git_repo = mailbox[uid] : 
                         fetch_field("Subject") : 
                         find(REPO_MATCHER)
        -- Make sure we actually have a repo
        if git_repo then
            -- Make sure the key is a table
            if not boxes[git_repo] then
                boxes[git_repo] = {}
            end
            -- Add this piece of mail
            table.insert(boxes[git_repo], {mailbox, uid})
        end
    end

    -- Move all of the mail to it's proper folder 
    for git_repo, mail_table in pairs(boxes) do
        local repo_folder = GIT_FOLDER .. "/" .. git_repo
        -- Make sure the folder for this repository exists
        icloud : create_mailbox(repo_folder)
        -- Move the messages there
        local table_set = Set(mail_table)

        if table.contains(WATCH_REPOS, git_repo) then
            table_set : copy_messages(icloud[IMPORTANT_FOLDER])
        end

        -- Mark the non-copied messages as seen.
        table_set : mark_seen()
        -- Always move the messages to the proper folder
        table_set : move_messages(icloud[repo_folder])
    end
end

function handle_all ()
    handle_git()
end

-- The actual loop to keep filtering messages
while true do
    handle_all()
    -- Wait for new mail
    did_idle = icloud.INBOX : enter_idle()

    -- If we can't idle, quit
    if not did_idle then
        print ("Couldn't IDLE, attempting check-status...")
        icloud.INBOX : check_status()
    end
end
