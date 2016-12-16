type game
external game : game = "Game" [@@bs.val]


let loop () = 
    Js.log game##spawns
