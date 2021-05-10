#!/usr/bin/env sh

InfoIgnore "Disabled"
apply_slack () { InfoIgnore 'not implemented'; }
return

# set -eu
#
# rm -rf ~/.tmp/slack
# mkdir -p ~/.tmp/slack
# rm -rf ~/.tmp/app.asar
#
# # cp -r ~/.tmp/slack_fresh_extract ~/.tmp/slack
# # asar extract /usr/lib/slack/resources/app.asar ~/.tmp/slack
# asar extract ~/dev/meta/configs/scripts/slack/backup/app.asar ~/.tmp/slack
# #
#
# sudo rm /usr/lib/slack/resources/app.asar || true
# sudo rm -rf /usr/lib/slack/resources/app.asar.unpacked || true
#
# base_path="$HOME/dev/meta/configs/meta-theme/icons/slack/png"
# main_bundle_path="$HOME/.tmp/slack/dist/main.bundle.js"
# noti_bundle_path="$HOME/.tmp/slack/dist/notifications.bundle.js"
# entry_point_path="$HOME/.tmp/slack/dist/preload.bundle.js"
#
# rest="data:image/png;base64,$(base64 -w 0 ${base_path}/slack-taskbar-rest.png)"
# sed -i "s|slack_taskbar_rest_default.a|\"$rest\"|g" $main_bundle_path
#
# highlight="data:image/png;base64,$(base64 -w 0 ${base_path}/slack-taskbar-highlight.png)"
# sed -i "s|slack_taskbar_highlight_default.a|\"$highlight\"|g" $main_bundle_path
#
# unread="data:image/png;base64,$(base64 -w 0 ${base_path}/slack-taskbar-unread.png)"
# sed -i "s|slack_taskbar_unread_default.a|\"$unread\"|g" $main_bundle_path
#
# JS="
#   const meta_css = '[lang] body {\
#     --sk_primary_foreground: 169,177,214;\
#     --sk_primary_background: 26,27,38;\
#     --sk_foreground_min_solid: 35,36,51;\
#     --sk_foreground_min: 23,24,33;\
#     --sk_foreground_high_solid: 43,44,62;\
#     --sk_foreground_max_solid: 76,86,106;\
#   }\
#   .c-message_kit__background--labels { background: #171821 !important; }\
#   \/* active chat sidebar */\
#   .p-channel_sidebar__channel--selected {\
#     color: #16a085 !important;\
#     font-weight: 900 !important;\
#   }\
#   \
#   \/* SELECTED */\
#   .p-channel_sidebar__channel--selected .p-channel_sidebar__channel_icon_prefix {\
#     color: #16a085 !important;\
#     font-weight: 900 !important;\
#   }\
#   \
#   \/* UNREAD TOP SIDEBAR */\
#   .p-channel_sidebar__link--unread .p-channel_sidebar__name {\
#     color: #81A2BE !important;\
#   }\
#   \/* UNREAD TOP SIDEBAR ICON */\
#   .p-channel_sidebar__link--unread .p-channel_sidebar__link__icon {\
#     color: #66aacc !important;\
#   }\
#   \
#   \/* UNREAD SIDEBAR ICON */\
#   .p-channel_sidebar__channel--unread:not(.p-channel_sidebar__channel--muted) .p-channel_sidebar__channel_icon_prefix {\
#     color: #66aacc !important;\
#   }\
#   \/* UNREAD NOT-MENTION SIDEBAR */\
#   .p-channel_sidebar__channel--unread:not(.p-channel_sidebar__channel--muted) .p-channel_sidebar__name:only-of-type {\
#     color: #81A2BE !important;\
#   }\
#   \/* UNREAD IS-MENTION SIDEBAR */\
#   .p-channel_sidebar__channel--unread:not(.p-channel_sidebar__channel--muted) .p-channel_sidebar__name:nth-last-of-type(2) {\
#     color: #CC6666 !important;\
#   }\
#   .c-texty_input { border-color: #232433 !important; } ';
#
#   let meta_s = document.createElement('style');
#   meta_s.type = 'text/css';
#   meta_s.innerHTML = meta_css;
#   setTimeout(() => {
#     document.head.appendChild(meta_s);
#   }, 10000);
# "
#
# tee -a "${entry_point_path}" > /dev/null <<< "$JS"
#
# asar pack ~/.tmp/slack ~/.tmp/app.patched.asar
#
# sudo cp ~/.tmp/app.patched.asar /usr/lib/slack/resources/app.asar
# sudo cp -r ~/.tmp/slack /usr/lib/slack/resources/app.asar.unpacked
#
# # ############################################################################ #
# # ############################################################################ #
