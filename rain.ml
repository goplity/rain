(* generate true with probability p, otherwise false *)
let roll p =
  Random.float 1.0 <= p

(* with probability   p, transition to a higher humidity state
 * with probability 1-p, transition to a lower  humidity state *)
let rec transition p increment =
  let yesrain = roll p in
  if yesrain then
    sim (p +. increment) increment
  else
    sim (p -. increment) increment
and sim state increment =
  (* Printf.printf "state %f\n" state; *)
  if state <= 0.0 then 0.0
  else 
   if state >= 1.0 then 1.0
   else transition state increment

let rec multirun num_runs init_state increment sum =
  match num_runs with
  | 0 -> sum
  | _ -> multirun (num_runs - 1)
                  init_state
                  increment 
                  (sum +. (sim init_state increment))

let () =
  let increment = float_of_string Sys.argv.(1) in
  let init_state = float_of_string Sys.argv.(2) in
  let runs = int_of_string Sys.argv.(3) in
  Random.self_init ();
  (* increment, initial state, probability of eternal rain *)
  Printf.printf
    "%f, %f, %f\n"
    increment
    init_state
    ((multirun runs init_state increment 0.0) /. (float_of_int runs))
