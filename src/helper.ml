
type game
type spawns
type spawn
external game : game = "Game" [@@bs.val]

external get_spawns : game -> spawns = "spawns" [@@bs.get]
external get_spawn : spawns -> string -> spawn = "" [@@bs.get_index]


let find_spawn name =
    get_spawn (get_spawns game) name
