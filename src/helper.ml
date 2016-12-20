type spawns


class type _spawn = object
    method createCreep : string array -> string -> 'a Js.t -> int [@bs.meth]
end [@bs]

type spawn = _spawn Js.t

class type _roomPos = object
    method x : int
    method y : int
    method roomName : string
end [@bs]

type roomPos = _roomPos Js.t


class type _carry = object
    method energy: int
end [@bs]

type carryType = _carry Js.t


class type _memory = object
    method role: string
end [@bs]

type memory = _memory Js.t

class type _creep = object
    method carryCapacity : int
    method moveTo : _roomPos -> int
    method carry : carryType
    method memory : memory
end [@bs]

type creep = _creep Js.t

type _creepsObj 
type creepsObj = _creepsObj Js.t

class type _game = object
    method spawns : spawns
    method creeps : creepsObj
end [@bs]

type game = _game Js.t

external extGame : game = "Game" [@@bs.val]

(* external get_spawns : game -> spawns = "spawns" [@@bs.get] *)
external get_spawn : spawns -> string -> spawn Js.undefined = "" [@@bs.get_index]
external get_creep : creepsObj -> string -> creep = "" [@@bs.get_index]

class type _obj = object
        method keys : 'a Js.t -> string array [@bs.meth]
end

type obj = _obj Js.t


external obj : obj = "Object" [@@bs.val]

let keys a = obj##keys a

let find_spawn game name =
    get_spawn (game##spawns) name


let arrayFilt : ('a -> bool) -> 'a array -> 'a array = fun filterfn arr ->
    let ls = Array.to_list arr in
    let fls = List.filter filterfn ls in
    Array.of_list fls


let creepsOfType game ctype =
    let cObj = game##creeps in
    let names = keys cObj in
    let creeps = Array.map (fun n -> get_creep cObj n) names
    in
        arrayFilt (fun c -> c##memory##role == ctype) creeps
