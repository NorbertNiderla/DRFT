#include <SPI.h>
#include <WiFi101.h>
#include <WiFiUdp.h>
#include <PubNub.h>

WiFiServer server(80);
char ssid[] = "DRFT_Project";
int status = WL_IDLE_STATUS;
WiFiUDP Udp;
unsigned int port = 80;
IPAddress ip(192,168,1,100);
void setup() {
  delay(1000);
  Serial.begin(9600);
  delay(500);
  Serial.print("[LOG] Creating AP: ");
  Serial.println(ssid);
  if (WiFi.beginAP(ssid) != WL_AP_LISTENING) {
    Serial.println("[LOG] Creating AP failed");
    while (true);
  }
  else Serial.print("[LOG] AP Created");
  server.begin();
  printStatus();
  Udp.begin(port);
}


void loop() {
  WiFiClient client = server.available();
  
  if (client) {
    Serial.println("[LOG] New client");
    String currentLine = "";
    //if (client.connect(ip, 80)) {
    //  Serial.println("still connected");
    //}
    while (client.connected()) {
      if (Serial.available()>0) {
        char c = Serial.read();
        Serial.print(ip);
        Serial.print(":");
        Serial.print(port);
        Serial.print("  ->\t");
        Serial.println(c);
        if(Udp.beginPacket(ip,port)) {
          Udp.write(c);
          if(Udp.endPacket()) Serial.println("endPacket ok");
          else Serial.println("endPacket fail");
        }
        else Serial.println("beginPacket fail");
        client.write(c);
        currentLine += c;
      }
    }
    Serial.println(currentLine);
    client.stop();
    Serial.println("[LOG] Client disconnected");
  }
}

void printStatus() {

  Serial.print("\n======= INFO =======");
  Serial.print("\nSSID:\t");
  Serial.println(WiFi.SSID());
  IPAddress ip = WiFi.localIP();
  Serial.print("IP:\t");
  Serial.println(ip);
  long rssi = WiFi.RSSI();
  Serial.print("RSSI:\t");
  Serial.print(rssi);
  Serial.println(" dBm");
  Serial.print("====================\n");
}
