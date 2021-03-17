module Rpa_ocaml =
(*link to rpa-python,use it to realize some robotic process automation*)
struct

  open Py
  open Pycaml
  open Printf
  open Base

  let() = Py.initialize ();;

  type taget =
    | Coordinate of int * int
    | Element of string
  ;;  

  let bool_to_UpString bool = 
    match bool with 
    |true ->"True"
    |false -> "False"
  ;;

let r = Py.import "rpa";;

(*core fuction *)
(*start TagUI, auto-setup on first run *)
  let init ~visual_automation  ~chrome_browser =
    let visual_automation = (bool_to_UpString visual_automation) in
    let chrome_browser = (bool_to_UpString chrome_browser) in
    Py.Module.get_function r "init" (Array.map [|visual_automation;chrome_browser|] Py.String.of_string);
    ()
  ;;
(*close TagUI, Chrome browser, SikuliX *)
  let close () = Py.Module.get_function r "close" [||];();;

(**deploy package which is related to rpa-python *)
  let pack () = Py.Module.get_function r "pack" [||];();;

(** update package without internet*) 
  let update() = Py.Module.get_function r "update" [||];();;

(*basic funtion *)
(**go to web URL, *)
let url webUrl = 
  let web = Py.String.of_string webUrl in
    Py.Module.get_function r "url" [|web|];
    ();;

(* get current URL*)      
let getUrl ()=
  let url = Py.Module.get_function r "url" [||] in
    Py.String.to_string url
;;

(**left click a element if find it by the keyword *)
let click_element element  = 
  let element = Py.String.of_string element in
    Py.Module.get_function r "click" [|element|];
    ();;

(**left click a element by coordor coordinateinate*)
let click_coordinate x y  = 
  let coordinate =  Array.map [|x;y|] Py.Int.of_int in
    Py.Module.get_function r "click" coordinate;
    ();;


(**right click a element if find it by the keyword *)
let rclick_element element  = 
  let element = Py.String.of_string element in
    Py.Module.get_function r "rclick" [|element|];
    ();;

(**right click a element by coordinate*)
let rclick_coordinate x y  = 
  let coordinate =  Array.map [|x;y|] Py.Int.of_int in
    Py.Module.get_function r "rclick" coordinate;
    ();;

(**double click a element if find it by the keyword *)
let dclick_element element  = 
  let element = Py.String.of_string element in
    Py.Module.get_function r "dclick" [|element|];
    ();;

(**double click a element by coordinate*)
let dclick_coordinate x y  = 
  let coordinate =  Array.map [|x;y|] Py.Int.of_int in
    Py.Module.get_function r "dclick" coordinate;
    ();;

(**move mouse to a element if find it by the keyword *)
let hover_element element  = 
  let element = Py.String.of_string element in
    Py.Module.get_function r "hover" [|element|];
    ();;

(**move mouse to a element by coordinate*)
let hover_coordinate x y  = 
  let coordinate =  Array.map [|x;y|] Py.Int.of_int in
    Py.Module.get_function r "hover" coordinate;
    ();;

(**enter text at element found by the keyword *)
let type_element element text = 
  let element = Py.String.of_string element in
  let text = Py.String.of_string text in
    Py.Module.get_function r "type" [|element;text|];
    ();;

(**enter text at element found by coordinate *)
let type_coordinate x y text = 
  let x = Py.Int.of_int x in
  let y = Py.Int.of_int y in
  let text = Py.String.of_string text in
    Py.Module.get_function r "type"
     [|x;y;text|];
    ();;

(*choose dropdown option*)
 let select_elem_option element option_value =
    let element = Py.String.of_string element in
    let option_value = Py.String.of_string option_value in
    Py.Module.get_function r "select" [|element;option_value|];
    ();;
  
  let select_elemXY_option elementX elementY option_value =
    let elementX = Py.Int.of_int elementX in
    let elementY = Py.Int.of_int elementY in
    let option_value = Py.String.of_string option_value in
    Py.Module.get_function r "select" [|elementX;elementY;option_value|];
    ();;

  let select_elem_optionXY element option_valueX option_valueY =
    let option_valueX = Py.Int.of_int option_valueX in
    let option_valueY = Py.Int.of_int option_valueY in
    let element = Py.String.of_string element in
    Py.Module.get_function r "select" [|element;option_valueX;option_valueY|];
    ();;
  
  let select_elemXY_optionXY elementX elementY option_valueX option_valueY =
    let input = Array.map [|elementX elementY option_valueX option_valueY|] Py.Int.of_int in
    Py.Module.get_function r "select" input;
    ();;

  (**fetch & return element text *)
  let read_element element = 
    let element = Py.String.of_string element in 
    let result = Py.Module.get_function r "read" [|element|] in
    Py.String.to_string result
  ;;
  
  let read_coordinate x1 y1 x2 y2 = 
    let input = Array.map [|x1;y1;x2;y2|] Py.Int.of_int in
    let result = Py.Module.get_function r "read" input in
    Py.String.to_string result
  ;;

  (**save screenshot to file *)
  let snap element filename =
    let input = Array.map [|element;filename|] Py.String.of_string in
    Py.Module.get_function r "snap" input;
    ();;

  (**load & return file content *)
  let load filename =
    let filename = Py.String.of_string filename in
    let result = Py.Module.get_function r "load" [|filename|] in
    Py.String.to_string result
  ;;

(**save text to file *)
  let dump text filename = 
    let text = Py.String.of_string text in
    let filename = Py.String.of_string filename in
    Py.Module.get_function r "dump" [|text;filename|];
    ();;

  (**append text to file *)
  let write text filename = 
    let text = Py.String.of_string text in
    let filename = Py.String.of_string filename in
    Py.Module.get_function r "write" [|text;filename|];
    ();;

  (**ask & return user input *)
  let ask ?text_to_prompt = 
    let text_to_prompt = match text_to_prompt with 
    |None -> ""
    |Some x -> x in
    let input = [|Py.String.of_string text_to_prompt|] in
    let result = Py.Module.get_function r "ask" input in
    Py.String.to_string result
    ;;


(*PRO FUNCTIONS *)
(**send keystrokes to screen *)
let keyboard keys_and_modifiers = 
  let keys_and_modifiers = Py.String.of_string keys_and_modifiers in
  Py.Module.get_function r "keyboard" [|keys_and_modifiers|];
  ();;
exception Invalid_input;;
(**send mouse event to screen 'down' or 'up' *)
let mouse move = 
  let move = match (String.lowercase move) with
    |"up"|"down" -> move
    |_-> raise Invalid_input in
    let move = Py.String.of_string move in
    Py.Module.get_function r "mouse" [|move|];
    ();;

(**explicitly wait for some time, default 5 seconds*)
let wait ?(time=5.0)  =
  let time =  Py.Float.of_float time in
   Py.Module.get_function r "wait" [|time|];
   ();;

(**save basic HTML table to CSV *)
let table element_XPath filename = 
  let input = Array.map [|element_XPath;filename|] Py.String.of_string in
  Py.Module.get_function r "table" input;
  ();;

(**upload file to web element *)
let upload element_CSS filename = 
  let input = Array.map [|element_CSS;filename|] Py.String.of_string in
  Py.Module.get_function r "upload" input;
  ();;
(**download from URL to file *)
let download url ?filename = 
  let filename = match filename with 
  |None ->""
  |Some x -> x in
  let input = Array.map [|url;filename|] Py.String.of_string in
  Py.Module.get_function r "download" input;
  ();;

(**unzip zip file to specified location *)
let unzip file_to_unzip ?unzip_location =
let unzip_location = match unzip_location with 
  |None ->""
  |Some x -> x in
  let input = Array.map [|file_to_unzip;unzip_location|] Py.String.of_string in
    Py.Module.get_function r "unzip" input;
    ();;

(**set web frame, frame() to reset *)
let frame ?(main_frame = "") ?(subframe = "") ()=
  let input = Array.map [|main_frame;subframe|] Py.String.of_string in
      Py.Module.get_function r "frame" input;
      ();;

(**set context to web popup tab ,no parameter to reset to main page*)
let popup ?(string_in_url="") =
  let string_in_url = Py.String.of_string string_in_url in
  Py.Module.get_function r "popup" [|string_in_url|];
  ();;

(**run OS command & return output can input more command and seperate by ";"  *)
let run command = 
  let command = Py.String.of_string command in
  let output = Py.Module.get_function r "run" [|command|] in
  Py.String.to_string output
  ;;

(**run code in DOM & return output *)
let dom statement_to_run =
  let statement_to_run = Py.String.of_string statement_to_run in
  let output = Py.Module.get_function r "dom" [|statement_to_run|] in
  Py.String.to_string output
  ;;

(**run custom SikuliX commands *)
let vision command =
  let command = Py.String.of_string command in
  Py.Module.get_function r "vision" [|command|];
  ();;

(**change wait timeout (default 10s) *)
let timeout time =
  let time = Py.Float.of_float time in
  Py.Module.get_function r "timeout" [|time|];
  ();;

(**get current timeout *)
let get_timeout () =
  let timeout = Py.Module.get_function r "timeout" [||] in
  Py.Float.to_float timeout
  ;;


(*HELPER FUNCTIONS *)
(**return true or false if element exists before timeout *)
let exist element = 
  let element = Py.String.of_string element in
  let is_exist = Py.Module.get_function r "exist" [|element|] in
  Pycaml.py_is_true is_exist
  ;;

(**return true or false if element is present now *)
let present element = 
  let element = Py.String.of_string element in
  let is_present = Py.Module.get_function r "present" [|element|] in
  Pycaml.py_is_true is_present
  ;;

(**return number of web elements  *)
let count element = 
  let element = Py.String.of_string element in
    let count = Py.Module.get_function r "count" [|element|] in
    Py.Int.to_int count
    ;;

(**put text to clipboard*)
let clipboard_put_text text = 
  let text = Py.String.of_string text in 
  Py.Module.get_function r "clipboard" [|text|];
  ();;
(**return clipboard text as string *)
let clipboard_return_text () =
  let text = Py.Module.get_function r "clipboard" [||] in
  Py.String.to_string text
  ;;

(**return '(x,y)' coordinates of mouse as string *)
let mouse_xy () =
  let result = Py.Module.get_function r "mouse_xy" [||] in
  Py.String.to_string result
  ;;

(**return x coordinate of mouse *)
let mouse_x () =
  let result = Py.Module.get_function r "mouse_x" [||] in
  Py.Int.to_int result
  ;;

(**return y coordinate of mouse *)
let mouse_y () =
  let result = Py.Module.get_function r "mouse_y" [||] in
  Py.Int.to_int result
  ;;

(**return page title of current web page as string *)
let title () =
  let result = Py.Module.get_function r "title" [||] in
  Py.String.to_string result
  ;;

(**return text content of current web page as string *)
let text () =
  let result = Py.Module.get_function r "text" [||] in
  Py.String.to_string result
  ;;

(**return time elapsed in sec between calls as float *)
let timer () =
  let result = Py.Module.get_function r "timer" [||] in
  Py.Float.to_float result
  ;;

(*file  *)
let write_to_file file message =
  let oc = open_out file in    
      fprintf oc "%s\n" message;   
      close_out oc; 
;;

let writeArray_to_file file messageArray = 
  let oc = open_out file in 
    for i = 0 to (Array.length messageArray) -1 do   
      fprintf oc "   %s" (messageArray.(i)); 
    done;  
    fprintf oc "\n";
    close_out oc; 
  ;;

let read_whole_file filename =
  let ic = open_in_bin filename in
    let s = really_input_string ic ((in_channel_length ic)-1) in
      close_in ic;
      s;
  ;;

let addArray_to_file file messageArray = 
  let beforemessage = read_whole_file file in
    let oc = open_out file in
      fprintf oc "%s\n" beforemessage;
      for i = 0 to (Array.length messageArray) -1 do   
      fprintf oc "   %s" (messageArray.(i)); 
      done;
      fprintf oc "\n";  
      close_out oc; 
  ;;


let writeArray_to_csv csvfile messageArray =
  let oc = open_out csvfile in 
    for i = 0 to (Array.length messageArray) -1 do
      if i = (Array.length messageArray) -1 then 
        fprintf oc "%s" (messageArray.(i))
      else fprintf oc "%s," (messageArray.(i));
    done;  
    fprintf oc "\n";
    close_out oc; 
  ;;

let addArray_to_csv csvfile messageArray = 
  let beforemessage = read_whole_file csvfile in
    let oc = open_out csvfile in
      fprintf oc "%s\n" beforemessage;
      for i = 0 to (Array.length messageArray) -1 do  
        if i = ((Array.length messageArray) -1) then 
          fprintf oc "%s" (messageArray.(i)) 
        else fprintf oc "%s," (messageArray.(i)); 
      done;
      fprintf oc "\n";  
      close_out oc; 
    ;;

let readline_from_file  file =
  let ic = open_in file in
    try 
      let line = input_line ic in  (* Read a line from the input channel and discard'\n' *)
        print_endline line;          
        flush stdout;                (* write to the default device *)
        close_in ic              
    with e ->                      
      close_in_noerr ic;          
      raise e      
    ;;
  

let rec read_whole_filelist filelist =
    match filelist with
    |[]->[]
    |x::tail
      ->let ic = open_in_bin x in
      (really_input_string ic (in_channel_length ic)) ::(read_whole_filelist tail)
      ;;
end;;
