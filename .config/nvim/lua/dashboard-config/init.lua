local home = os.getenv('HOME')
local db = require('dashboard')
db.custom_header = {
    [[ __  ___  _______  _______ .______        ______      ___       __      .___  ___.         ___      .__   __.  _______       ______   ______    _______   _______      ______   .__   __.]],
    [[|  |/  / |   ____||   ____||   _  \      /      |    /   \     |  |     |   \/   |        /   \     |  \ |  | |       \     /      | /  __  \  |       \ |   ____|    /  __  \  |  \ |  |]],
    [[|  '  /  |  |__   |  |__   |  |_)  |    |  ,----'   /  ^  \    |  |     |  \  /  |       /  ^  \    |   \|  | |  .--.  |   |  ,----'|  |  |  | |  .--.  ||  |__      |  |  |  | |   \|  |]],
    [[|    <   |   __|  |   __|  |   ___/     |  |       /  /_\  \   |  |     |  |\/|  |      /  /_\  \   |  . `  | |  |  |  |   |  |     |  |  |  | |  |  |  ||   __|     |  |  |  | |  . `  |]],
    [[|  .  \  |  |____ |  |____ |  |         |  `----. /  _____  \  |  `----.|  |  |  |     /  _____  \  |  |\   | |  '--'  |   |  `----.|  `--'  | |  '--'  ||  |____    |  `--'  | |  |\   |]],
    [[|__|\__\ |_______||_______|| _|          \______|/__/     \__\ |_______||__|  |__|    /__/     \__\ |__| \__| |_______/     \______| \______/  |_______/ |_______|    \______/  |__| \__|]],
    [[]],
    [[]],
    [[]],
    [[                           _                           ]],
    [[                        _ooOoo_                        ]],
    [[                       o8888888o                       ]],
    [[                       88" . "88                       ]],
    [[                       (| -_- |)                       ]],
    [[                       O\  =  /O                       ]],
    [[                    ____/`---'\____                    ]],
    [[                  .'  \\|     |//  `.                  ]],
    [[                 /  \\|||  :  |||//  \                 ]],
    [[                /  _||||| -:- |||||_  \                ]],
    [[                |   | \\\  -  /'| |   |                ]],
    [[                | \_|  `\`---'//  |_/ |                ]],
    [[                \  .-\__ `-. -'__/-.  /                ]],
    [[              ___`. .'  /--.--\  `. .'___              ]],
    [[           ."" '<  `.___\_<|>_/___.' _> \"".           ]],
    [[          | | :  `- \`. ;`. _/; .'/ /  .' ; |          ]],
    [[          \  \ `-.   \_\_`. _.'_/_/  -' _.' /          ]],
    [[===========`-.`___`-.__\ \___  /__.-'_.'_.-'================]],
    [[                        `=--=-'                        ]],
    [[]],
    [[]],
    [[]],
}
db.custom_center = {
    {icon = '  ',
    desc = 'Recently latest session                  ',
    shortcut = 'SPC s l',
    action ='SessionLoad'},
    {icon = '  ',
    desc = 'Recently opened files                   ',
    action =  'Telescope oldfiles',
    shortcut = 'SPC f h'},
    {icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f f'},
    {icon = '  ',
    desc ='File Browser                            ',
    action =  'Telescope file_browser',
    shortcut = 'SPC f b'},
    {icon = '  ',
    desc = 'Find  word                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f w'},
    {icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'Telescope dotfiles path=' .. home ..'/.dotfiles',
    shortcut = 'SPC f d'},
}
