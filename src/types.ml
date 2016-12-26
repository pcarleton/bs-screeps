
module Spawn = struct
    type spawnInfo = {
        name: string;
        needTime: int;
        remainingTime: int;
    }

    type t = {
        name : string;
        energy : int;
        spawning : spawnInfo option
    }
end

module Creep = struct
    type t = { name : string}
end

module StringMap = Map.Make(String)

module GameState = struct
    type t = {
        spawns: Spawn.t StringMap.t;
        creeps: Creep.t array;
    }
end

