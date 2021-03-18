# RPA_OCAML:

[**Use Cases**](#use-cases)&ensp;|&ensp;[**API Reference**](#api-reference)&ensp;|&ensp;[**About & Credits**](#about--credits)&ensp;|&ensp;

To use it in ocaml file or utop
```python
open Rpa_ocaml
```

RPA_OCAML realizes robotic process automation by [rpa_python](https://github.com/tebelorg/RPA-Python) supported.

# Use Cases

Rpa_ocaml is an interface module that help to realize some robotic process automation in ocaml through rpa_python package supported.
You can use simple ocaml code to quickly finish automate repetitive time-consuming tasks, whether the tasks involve websites, desktop applications, or the command line.
Meanwhile, errors in coding and testing will decrease because of ocaml language's features.

#### WEB AUTOMATION:
```ocaml
let () = Rpa_ocaml.init false true
let () = Rpa_ocaml.url "https://www.google.com"
let () = Rpa_ocaml.type_text (Element "//*[@name=\"q\"]") "decentralization[enter]"
let result = Rpa_ocaml.read (Element_range "result-stats")
let () = printf "%s" result
let () = Rpa_ocaml.snap "page" "results.png"
let () = Rpa_ocaml.close ()
```

#### VISUAL AUTOMATION:
```ocaml
let () = Rpa_ocaml.init true true
let () = Rpa_ocaml.dclick (Element "outlook_icon.png")
let () = Rpa_ocaml.click( Element "new_mail.png")
...
let () = Rpa_ocaml.type_text (Element "message_box.png") "message"
let () = Rpa_ocaml.click (Element "send_button.png")
let () = Rpa_ocaml.close()
```

#### OCR AUTOMATION:
```ocaml
let () = Rpa_ocaml.init ~visual_automation:true ~chrome_browser:false
let () = printf "%s" (Rpa_ocaml.read (Element_range "pdf_window.png"))
let () = printf "%s" (Rpa_ocaml.read (Element_range "image_preview.png"))
let () = Rpa_ocaml.hover (Element "anchor_element.png")
let () = printf "%s" (Rpa_ocaml.read (Range (Rpa_ocaml.mouse_x(),Rpa_ocaml.mouse_y(),Rpa_ocaml.mouse_x() + 400,Rpa_ocaml.mouse_y() + 200)))
let () = Rpa_ocaml.close()
```

#### KEYBOARD AUTOMATION:
```ocaml
let () = Rpa_ocaml.init ~visual_automation:true ~chrome_browser:false
let () = Rpa_ocaml.keyboard "[cmd][space]"
let () = Rpa_ocaml.keyboard "safari[enter]"
let () = Rpa_ocaml.keyboard "[cmd]t"
let () = Rpa_ocaml.keyboard "joker[enter]"
let () = Rpa_ocaml.wait ~time:2.5 ()
let () = Rpa_ocaml.snap "page.png" "results.png"
let () = Rpa_ocaml.close()
```

#### MOUSE AUTOMATION
```ocaml
let () = Rpa_ocaml.init true true
let () = Rpa_ocaml.type_text (Coordinate(600, 300)) "open source"
let () = Rpa_ocaml.click (Coordinate(900, 300))
let () = Rpa_ocaml.snap "page.bmp" "results.bmp"
let () = Rpa_ocaml.hover (Element "button_to_drag.bmp")
let () = Rpa_ocaml.mouse "down"
let () = Rpa_ocaml.hover (Coordinate(Rpa_ocaml.mouse_x() + 300, Rpa_ocaml.mouse_y()))
let () = Rpa_ocaml.mouse "up"
let () = Rpa_ocaml.close()
```

# API Reference

Two special type defined as below

```ocaml
* type target =
| Coordinate of int * int
| Element of string
;;
```
```ocaml
* type target_range =
| Range of int * int * int* int
| Element_range of string
;;
```

#### CORE FUNCTIONS
Function|Parameters|Purpose
:-------|:---------|:------
init|~visual_automation:Bool  ~chrome_browser:Bool |start TagUI, auto-setup on first run
close |()|close TagUI, Chrome browser, SikuliX
pack |()|for deploying package without internet
update |()|for updating package without internet

>_to print and log debug info to rpa_python.log use debug(True), to switch off use debug(False)_

#### BASIC FUNCTIONS
Function|Parameters|Purpose
:-------|:---------|:------
url|webUrl:String|go to web URL
getUrl|()|get current URL
click|element_or_coordinate:target| left-click on element
rclick|element_or_coordinate:target|right-click on element
dclick|element_or_coordinate:target|double-click on element
hover|element_or_coordinate:target|move mouse to element
type_text|element_or_coordinate:target text:String ("[enter]")|enter text at element
select|element_identifier (or x, y):target   option_value (or x, y):target|choose dropdown option
read|element_identifier (page = web page)(or x1, y1, x2, y2):target_range|fetch & return element text
snap|element_identifier (page = web page):String  filename:String|save screenshot to file
load|filename:String|load & return file content
dump|text:String  filename:String|save text to file
write|text:String  filename:Stringappend text to file
ask|text_to_prompt(optional):String   ()|ask & return user input

>_to wait for an element to appear until timeout() value, use hover(). to drag-and-drop, [you can do this](https://github.com/tebelorg/RPA-Python/issues/58#issuecomment-570778431)_

#### PRO FUNCTIONS
Function|Parameters|Purpose
:-------|:---------|:------
keyboard|keys_and_modifiers:String|send keystrokes to screen
mouse|move("down" or "up")|send mouse event to screen
wait|time(option,default 5 seconds):float  ()|explicitly wait for some time
table|element_XPath:String   filename:String|save basic HTML table to CSV
upload|element_CSS:String   filename:String|upload file to web element
download|url:String   filename(optional)  ()|download from URL to file
unzip|file_to_unzip:String    unzip_location (optional):String   ()|unzip zip file to specified location
frame|main_frame (optional):String   sub_frame (optional):String   ()|set web frame, frame () to reset
popup|string_in_url (optional) :String|set context to web popup tab,popup () to reset to main page
run|command (use ; between commands):String |run OS command & return output
dom|statement_to_run (JS code to run in browser):String|run code in DOM & return output
vision|command (Python code for SikuliX):String|run custom SikuliX commands
timeout|time :Float|change wait timeout
get_timeout|()|get current timeout

keyboard() modifiers and special keys -
>_[shift] [ctrl] [alt] [cmd] [win] [meta] [clear] [space] [enter] [backspace] [tab] [esc] [up] [down] [left] [right] [pageup] [pagedown] [delete] [home] [end] [insert] [f1] .. [f15] [printscreen] [scrolllock] [pause] [capslock] [numlock]_

#### HELPER FUNCTIONS
Function|Parameters|Purpose
:-------|:---------|:------
exist|element_:String|return True or False if element exists before timeout
present|element:String|return True or False if element is present now
count|element:String|return number of web elements as integer
clipboard_put_text|text:String|put text 
clipboard_return_text|()|return clipboard text as string
mouse_xy|()|return '(x,y)' coordinates of mouse as string
mouse_x|()|return x coordinate of mouse as integer
mouse_y|()|return y coordinate of mouse as integer
title|()|return page title of current web page as string
text|()|return text content of current web page as string
timer|()|return time elapsed in sec between calls as float

### FILE CONTROL FUNCTIONS
Function|Parameters|Purpose
:-------|:---------|:------
write_to_file|file:String message:String|write message to file from beginning
writeArray_to_file |file :String messageArray:Array|write message which is saved in a Array to file from beginning
read_whole_file|filename:String|read whole file and return as a string
addArray_to_file|file:String messageArray:Array|add new message to a file
writeArray_to_csv|csvfile:String messageArray:Array |write message array to a csv file
addArray_to_csv|csvfile:String messageArray:Array|radd new message to a csv file
readline_from_file|file:String|read a line String from file
read_whole_filelist|filelist:String List|read string from a list of file

