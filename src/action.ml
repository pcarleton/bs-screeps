
module SpawnArgs = struct
    type t = {parts: string array; role : string;
                  name: string}
    let basicHarvester name = 
         {parts = [|"move"; "carry"; "work"|];
          role = "harvester";
          name}
end

type spawnAction =
    Nothing | Spawn of SpawnArgs.t 

let makeSpawnActions game =
    [("Spawn1", Spawn (SpawnArgs.basicHarvester "harvester1"))]

