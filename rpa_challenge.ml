open Rpa_ocaml;;
open Core
open Py
open Base

let () = Rpa_ocaml.init true true
let () = Rpa_ocaml.url "http://rpachallenge.com"
let () = Rpa_ocaml.wait ~time:15.0 ();;
let () = Rpa_ocaml.click (Element "/html/body/app-root/div[2]/app-rpa1/div/div[1]/div[6]/button")
let data = Rpa_ocaml.read_csvfile_to_ArrayArray "challenge.csv"
let fillin = 
  for i =1 to (Array.length data)-1 do
    Rpa_ocaml.type_text (Element "//LABEL[@_ngcontent-c2=''][text()='First Name']/following-sibling::INPUT") data.(i).(0);
    Rpa_ocaml.type_text (Element "//LABEL[@_ngcontent-c2=''][text()='Last Name']/following-sibling::INPUT") data.(i).(1);
    Rpa_ocaml.type_text (Element "//LABEL[@_ngcontent-c2=''][text()='Company Name']/following-sibling::INPUT") data.(i).(2);
    Rpa_ocaml.type_text (Element "//LABEL[@_ngcontent-c2=''][text()='Role in Company']/following-sibling::INPUT") data.(i).(3);
    Rpa_ocaml.type_text (Element "//LABEL[@_ngcontent-c2=''][text()='Address']/following-sibling::INPUT") data.(i).(4);
    Rpa_ocaml.type_text (Element "//LABEL[@_ngcontent-c2=''][text()='Email']/following-sibling::INPUT") data.(i).(5);
    Rpa_ocaml.type_text (Element "//LABEL[@_ngcontent-c2=''][text()='Phone Number']/following-sibling::INPUT") data.(i).(6);
    Rpa_ocaml.click (Element "/html/body/app-root/div[2]/app-rpa1/div/div[2]/form/input");
    Rpa_ocaml.wait ~time:8.0 ();
  done
;;

let () = Rpa_ocaml.snap "/html/body/app-root/div[2]/app-rpa1/div" "score.png";;
let () = Rpa_ocaml.wait ~time:10.0 ();;

let () = Rpa_ocaml.close ()
