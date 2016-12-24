
(* type spawn = {name : string; energy : int} *)
module Spawn = struct
    type t = {name : string; energy : int }
end

module Creep = struct
    type t = { name : string}
end

module GameState = struct
    type t = {
        spawns: Spawn.t array;
        creeps: Creep.t array;
    }
end

