import processing.net.*;

String HTTP_GET_REQUEST = "GET /";
String HTTP_POST_REQUEST = "POST /";
String HTTP_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n";
String landingPage = "<!DOCTYPE html><html lang='en' dir='ltr'><head><meta charset='utf-8'><title>Josh Boddy | Processing Web Server</title><style>body{background-color: black;}#container{text-align: center;color: white;font-family: arial;display: flex;flex-direction: column;font-weight: bold;}#container > h1{font-size: 40px;line-height: 100px;}#container > h1 > span:nth-child(2n){color: red;}p{font-size: 32px;}form{display: flex;flex-direction: row;}#name{background: transparent;border: none transparent;outline: transparent;border-bottom: 5px solid white;color: white;font-size: 32px;text-align: center;}#submit{background: transparent;border: 5px solid white;outline: none;font-size: 20px;border-top-right-radius: 20px;border-bottom-right-radius: 20px;color: white;padding: 20px;font-weight: bold;}#submit:hover{color: black;background: white;cursor: pointer;}</style></head><body><div id='container'><h1><span>Welcome to </span><span><i>City</i></span><span> <i>Computer Science!</i></span></h1><p>Processing is a powerful tool, not only visually, but also on a network!</p><p>This server is running through Processing and hosting the HTML that you can see now!</p><p>Type your name or an alias into the form below to have it display on the main board!</p><form method='post'><div style='display: hidden; flex: 2;'></div><input type='text' name='name' id='name' autocomplete='off' style='flex: 10'/><input type='submit' value='Display!' id='submit' style='flex: 2'/><div style='display: hidden; flex: 2;'></div></form></div></body></html>";
String nameTag = "name=";

ArrayList<String> names = new ArrayList<String>();

// posX = 0
// posY = 1
// cols = 2
// sizes = 3

ArrayList<ArrayList<Integer>> nameData = new ArrayList<ArrayList<Integer>>();

Server s;
Client c;
String input;
String input2;
int responseIndex;
String response;

int offsetX;
int offsetY;

void setup(){
  size(600, 600);
  background(0);
  s = new Server(this, 8080);
}

void draw(){
  background(0);
  c = s.available();
  if (c != null) {
    input = c.readString();
    input2 = input.substring(0, input.indexOf("\n"));
    if (input2.indexOf(HTTP_GET_REQUEST) == 0){
      c.write(HTTP_HEADER);
      c.write(landingPage);
      c.stop();
    } else if(input2.indexOf(HTTP_POST_REQUEST) == 0){
      responseIndex = input.indexOf(nameTag) + 4;
      names.add(input.split("name=")[1]);
      nameData.add(new ArrayList<Integer>());
      c.write(HTTP_HEADER);
      c.write(landingPage);
      c.stop();
    }
  }
  for(int i = 0; i < names.size(); i++){
    nameData.get(i).add(int(random(50, 400)));
    nameData.get(i).add(int(random(50, 400)));
    nameData.get(i).add(color(int(random(255)), int(random(255)), int(random(255))));
    nameData.get(i).add(int(random(20, 50)));
    fill(nameData.get(i).get(2));
    textSize(nameData.get(i).get(3));
    text(names.get(i), nameData.get(i).get(0), nameData.get(i).get(1));
  }
}
