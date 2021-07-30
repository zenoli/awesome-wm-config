local tag_ids = {
    home = 1,
    tmux = 2,
    web = 3,
    mail = 4,
    slack = 5,
    video = 6,
    code = 7,
    vim = 8,
    countdown = 9,
    calendar = 10,
    pdf = 11,
    workspace_1 = 12,
    workspace_2 = 13,
    workspace_3 = 14
}


local = tag_icons
tag_icons[tag_ids.home       ] = " "
tag_icons[tag_ids.tmux       ] = " "
tag_icons[tag_ids.web        ] = "爵 "
tag_icons[tag_ids.mail       ] = " "
tag_icons[tag_ids.slack      ] = " "
tag_icons[tag_ids.video      ] = " "
tag_icons[tag_ids.code       ] = "﬏ "
tag_icons[tag_ids.vim        ] = " "
tag_icons[tag_ids.countdown  ] = "祥 "
tag_icons[tag_ids.calendar   ] = " "
tag_icons[tag_ids.pdf        ] = " "
tag_icons[tag_ids.workspace_1] = "1"
tag_icons[tag_ids.workspace_2] = "2"
tag_icons[tag_ids.workspace_3] = "3"


function get_tag_by_id(tag_id) 
    return tag_icons[tag_ids[tag_id]]
end
