open Rpa_ocaml;;
open Core
open Py
open Base

let link_to_web = 
    Rpa_ocaml.init true true;
    Rpa_ocaml.url "https://mail.google.com/";
    Rpa_ocaml.wait ~time:15.0;
;;

let user_account = "wtao0717@gmail.com";;
let password = "3580266.";;

let person_email = [|"wang_tao0717@163.com";"wang_tao0717@163.com";"wang_tao0717@163.com"|];;
let person_name = [|"Jenny";"Ella";"Zheng Yi"|];;
let students_grade = [|"A";"B+";"A+"|];;
let subjects name = "result of C1243 --- "^name;;

let template name grade= "Dear "^name^",\n"^
                "Your grade in this course is "^grade^" .\n"^
                "This is an automated email. No acknowledgement is necessary. But you can reply to this email if you need clarifications or help.\n"
;;


let link_to_log_web = 
  Rpa_ocaml.type_text (Element "//*[@id=\"identifierId\"]") user_account;
  Rpa_ocaml.click (Element "//*[@id=\"identifierNext\"]/div/button/div[2]");
  Rpa_ocaml.wait ~time:15.0 ();
  Rpa_ocaml.type_text (Element "//*[@id=\"password\"]/div[1]/div/div[1]/input") password;
  Rpa_ocaml.wait ~time:15.0 ();
  Rpa_ocaml.click(Element "//*[@id=\"passwordNext\"]/div/button/div[2]");
  Rpa_ocaml.wait ~time: 20.0 ();;
 
 let send_email = 
  for i = 0 to (Array.length person_name)-1 do
        Rpa_ocaml.click (Element "Compose");
        Rpa_ocaml.wait ~time:10.0 ();
        Rpa_ocaml.type_text (Element "Recipient") person_email.(i);
        Rpa_ocaml.type_text (Element "Subject") (subjects person_name.(i));
        Rpa_ocaml.type_text (Element "Am Al editable LW-avf tS-tW") (template person_name.(i) students_grade.(i));
        Rpa_ocaml.wait ~time: 5.0 ();
        (*click send bottom *)
        Rpa_ocaml.click (Element "T-I J-J5-Ji aoO v7 T-I-atl L3");
        Rpa_ocaml.wait ~time: 5.0 ();
  done;
;;

let log_out =
  Py.Module.get_function r "click" [|(Py.String.of_string "//*[@id=\"gb\"]/div[2]/div[3]/div[1]/div[2]/div/a/img")|];
  Py.Module.get_function r "wait" [|(Py.Float.of_float 3.0)|];
  Py.Module.get_function r "click" [|(Py.String.of_string "//*[@id=\"gb_71\"]")|];
  Py.Module.get_function r "wait" [|(Py.Float.of_float 3.0)|];
  Py.Module.get_function r "click" [|(Py.String.of_string "//*[@id=\"view_container\"]/div/div/div[2]/div/div[1]/div/form/span/section/div/div/div/div/ul/li[3]/div/div/div[2]")|];
  Py.Module.get_function r "wait" [|(Py.Float.of_float 3.0)|];
  Py.Module.get_function r "click" [|(Py.String.of_string "//*[@id=\"profileIdentifier\"]")|];
  Py.Module.get_function r "wait" [|(Py.Float.of_float 3.0)|];
  Py.Module.get_function r "click" [|(Py.String.of_string "//*[@id=\"yDmH0d\"]/div[5]/div/div[2]/div[3]/div[1]/span")|];
;;


let close_window = 
    Py.Module.get_function r "close" [||]
;;
