open Rpa_ocaml;;
open Core;;

let citiesArray = [|"Singapore";"Beijing";"Shanghai";"Fuzhou";"New York";"Mexico City";"Melbourne"|];;
(*let citiesArray = [|"Singapore";"Beijing"|]*)
let weather = [|[|"Date"; "High_temperature"; "Low_temperature"; "Wind_speed";"Wind_Direction"; "weather_Description"|]|];;

let link_to_web = 
    Rpa_ocaml.init false true;
    Rpa_ocaml.url "https://www.bbc.com/weather";
    Rpa_ocaml.wait ~time:15.0 ();
;;
 

let find_weather city = 
    Rpa_ocaml.type_text (Element "ls-c-search__input-label") city;
    Rpa_ocaml.click (Element "Search for a location");
    Rpa_ocaml.wait ~time:8.0 (); 
    Rpa_ocaml.click (Element "ls-o-location ls-o-location--dark gel-pica");
    Rpa_ocaml.wait ~time:15.0 ();
    Rpa_ocaml.snap "page" ("result_"^city^".png");
    
;;

let save_weather_data file weather= 
    for i = 0 to (Array.length weather)-1 do
      addArray_to_file file weather.(i);
    done;
    addArray_to_file file [||]
;;

let save_weather_data_tocsv csvfile weather = 
    for i = 0 to (Array.length weather)-1 do
      addArray_to_csv csvfile weather.(i);
    done;
    addArray_to_csv csvfile [||]
;;

let main = 
  for city_num = 0 to (Array.length citiesArray)-1 do
    if city_num = 0 
    then (writeArray_to_file "weather_result" [|citiesArray.(city_num)|];
          writeArray_to_csv "weather_result.csv" [|citiesArray.(city_num)|])
    else (addArray_to_file "weather_result" [|citiesArray.(city_num)|];
          addArray_to_csv "weather_result.csv" [|citiesArray.(city_num)|]);
    find_weather citiesArray.(city_num);
      let weather = 
        let resultArray = ref [|[|"Date"; "High_temperature"; "Low_temperature"; "Wind_speed";"Wind_Direction"; "weather_Description"|]|] in
          for i = 1 to 10 do 
              let date = Rpa_ocaml.read (Element_range ("//*[@id=\"daylink-" ^ (Int.to_string i) ^ "\"]/div[2]/div/span[1]")) in
              let high_temperature = Rpa_ocaml.read (Element_range("//*[@id=\"daylink-" ^ (Int.to_string i) ^ "\"]/div[4]/div[1]/div/div[4]/div/div[1]/span[2]/span/span[1]")) in
              let low_temperature = Rpa_ocaml.read (Element_range ("//*[@id=\"daylink-" ^ (Int.to_string i) ^ "\"]/div[4]/div[1]/div/div[4]/div/div[2]/span[2]/span/span[1]")) in
              let wind_speed = Rpa_ocaml.read (Element_range ("//*[@id=\"daylink-" ^ (Int.to_string i) ^ "\"]/div[4]/div[1]/div/div[6]/div/span[2]/span[1]/span/span[1]")) in
              let wind_Direction = Rpa_ocaml.read (Element_range ("//*[@id=\"daylink-" ^ (Int.to_string i) ^ "\"]/div[4]/div[1]/div/div[6]/div/span[4]")) in
              let weather_Discription = Rpa_ocaml.read (Element_range ("//*[@id=\"daylink-" ^ (Int.to_string i) ^ "\"]/div[4]/div[2]")) in
              let result =[|date;high_temperature;low_temperature;wind_speed;wind_Direction;weather_Discription|] in
              resultArray:= Array.append (!resultArray) [|result|];
          done;
              !resultArray in
          save_weather_data "weather_result" weather;
          save_weather_data_tocsv "weather_result.csv" weather;
  done;
        ;;


let close_window = 
    Rpa_ocaml.close()
;;
