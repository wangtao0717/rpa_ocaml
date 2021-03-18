open Rpa_ocaml;;
open Core;;

(**WEB AUTOMATION *)
let () = Rpa_ocaml.init false true
let () = Rpa_ocaml.url "https://www.google.com"
let () = Rpa_ocaml.type_text (Element "//*[@name=\"q\"]") "decentralization[enter]"
let result = Rpa_ocaml.read (Element_range "result-stats")
let () = printf "%s\n" result
let () = Rpa_ocaml.snap "page" "results.png"
let () = Rpa_ocaml.close ()

(**VISUAL AUTOMATION *)
let () = Rpa_ocaml.init true false
let () = Rpa_ocaml.dclick (Element "outlook_icon.png")
let () = Rpa_ocaml.click( Element "new_mail.png")
let () = Rpa_ocaml.type_text (Element "message_box.png") "message"
let () = Rpa_ocaml.click (Element "send_button.png")
let () = Rpa_ocaml.close()

(**OCR AUTOMATION *)
let () = Rpa_ocaml.init ~visual_automation:true ~chrome_browser:false
let () = printf "%s\n" (Rpa_ocaml.read (Element_range "pdf_window.png"))
let () = printf "%s\n" (Rpa_ocaml.read (Element_range "image_preview.png"))
let () = Rpa_ocaml.hover (Element "anchor_element.png")
let () = printf "%s\n" (Rpa_ocaml.read (Range (Rpa_ocaml.mouse_x(),Rpa_ocaml.mouse_y(),Rpa_ocaml.mouse_x() + 400,Rpa_ocaml.mouse_y() + 200)))
let () = Rpa_ocaml.close()

(**KEYBOARD AUTOMATION *)
let () = Rpa_ocaml.init ~visual_automation:true ~chrome_browser:false
let () = Rpa_ocaml.keyboard "[cmd][space]"
let () = Rpa_ocaml.keyboard "safari[enter]"
let () = Rpa_ocaml.keyboard "[cmd]t"
let () = Rpa_ocaml.keyboard "joker[enter]"
let () = Rpa_ocaml.wait ~time:2.5 ()
let () = Rpa_ocaml.snap "page.png" "results.png"
let () = Rpa_ocaml.close()

(**MOUSE AUTOMATION *)
let () = Rpa_ocaml.init true true
let () = Rpa_ocaml.type_text (Coordinate(600, 300)) "open source"
let () = Rpa_ocaml.click (Coordinate(900, 300))
let () = Rpa_ocaml.snap "page.bmp" "results.bmp"
let () = Rpa_ocaml.hover (Element "button_to_drag.bmp")
let () = Rpa_ocaml.mouse "down"
let () = Rpa_ocaml.hover (Coordinate(Rpa_ocaml.mouse_x() + 300, Rpa_ocaml.mouse_y()))
let () = Rpa_ocaml.mouse "up"
let () = Rpa_ocaml.close()
