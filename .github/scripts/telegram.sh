#!/bin/sh


echo $TELEGRAM_CHAT_ID
echo $STATUS

end
return
# Get the token from Travis environment vars and build the bot URL:
BOT_URL="https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage"

# Set formatting for the message. Can be either "Markdown" or "HTML"
PARSE_MODE="Markdown"

# Use built-in Travis variables to check if all previous steps passed:
if [ $STATUS -ne 0 ]; then
    build_status="failed"
else
    build_status="succeeded"
fi

# Define send message function. parse_mode can be changed to
# HTML, depending on how you want to format your message:
send_msg () {
    curl -s -X POST ${BOT_URL} -d chat_id=${TELEGRAM_CHAT_ID} \
        -d text="$1" -d parse_mode=${PARSE_MODE}
}

# Send message to the bot with some pertinent details about the job
# Note that for Markdown, you need to escape any backtick (inline-code)
# characters, since they're reserved in bash
send_msg "
-------------------------------------
Github action *${build_status}!*
\`Repository:  ${GITHUB_REPOSITORY}\`
\`Branch:      ${GITHUB_REF_NAME}\`
[Job Log here](${$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID})
--------------------------------------
"
