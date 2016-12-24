
class type _extSpawn = object
    method name: string
    method energy: int
end [@bs]

type extSpawn = _extSpawn Js.t

class type _extCreep = object
    method name : string
end [@bs]
type extCreep = _extCreep Js.t

type 'a objsH

class type _game = object
    method spawns : extSpawn objsH 
    method creeps : extCreep objsH 
end [@bs]

type extGame = _game Js.t

external globalGame : extGame= "Game" [@@bs.val]


let objVals : 'a objsH -> 'a array = [%bs.raw "Object.values" ] 
(* This shouldn't be necessary... I don't know why it doesn't
 * work with the above one *)
let spVals : 'a objsH -> 'a array = [%bs.raw "Object.values" ] 

let convCreep c = 
    let open Types.Creep in
    {name = c##name}

let convSpawn : extSpawn -> Types.Spawn.t = fun s ->
    let open Types.Spawn in
    {name = s##name; energy = s##energy}


let convertExternal : extGame -> Types.GameState.t = fun g ->
        let creeps = Array.map convCreep (objVals g##creeps) in
        let spawns = Array.map convSpawn (spVals g##spawns) in
        let open Types.GameState in
        { creeps; spawns }

let convertGlobal _ =
    convertExternal globalGame
