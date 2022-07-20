#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <Firebase_ESP_Client.h>
#include <Wire.h>
#include <NTPClient.h>
#include <WiFiUdp.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#define WIFI_SSID "bhavya"
#define WIFI_PASSWORD "secure@133"


#define API_KEY "AIzaSyCm63q1OOmGKf3PDMZ_iPgA-q0u9zkeR8w"

#define USER_EMAIL "pankajtalesara01@gmail.com"
#define USER_PASSWORD "firebase123"

#define DATABASE_URL "https://workerkhojo-6e71a-default-rtdb.firebaseio.com/"

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
unsigned long timerDelay = 5000;

float safeTemperature;
FirebaseJson json;
int outputpin = A0;

String parentPath;
String uid;

String databasePath = "/vaccine1";
String tempPath = "/temperature";
String statusPath = "/status";
String dbPath = "safeTemp";

void initWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi ..");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(1000);
  }
  Serial.println(WiFi.localIP());
  Serial.println();
}

void setup() {
  Serial.begin(115200);
  initWiFi();
  config.api_key = API_KEY;

  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.database_url = DATABASE_URL;
  
  Firebase.reconnectWiFi(true);
  fbdo.setResponseSize(4096);

  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h

  config.max_token_generation_retry = 5;

  Firebase.begin(&config, &auth);

  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
    Serial.print('.');
    delay(1000);
  }
  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.println(uid);

  Firebase.RTDB.getInt(&fbdo, dbPath);
  safeTemperature = fbdo.to<int>();
}

bool touchState;
float analogValue = 0, celsius = 0;

void indicate(float celsius) {
  if (celsius > safeTemperature) {
      digitalWrite(D3, HIGH);
      delay(5000);
      digitalWrite(D3, LOW);
    } else {
      digitalWrite(D7, HIGH);
      delay(5000);
      digitalWrite(D7, LOW);
    }
}

void updateData(float celsius) {
  if (Firebase.ready()){
    json.set(tempPath.c_str(), celsius);
    if (celsius > safeTemperature) {
      json.set(statusPath, String("Safe"));  
    } else {
      json.set(statusPath, String("Critical"));
    }
    
    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, databasePath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
  }
}


void loop() {
  Serial.print("Safe temperature: ");
  Serial.println(safeTemperature);
  touchState = digitalRead(D0);
  
  analogValue = analogRead(outputpin);
  celsius = (analogValue/1024.0) * 330;

  Serial.print("celsius: ");
  Serial.println(celsius);
  
  Serial.print("State: ");
  Serial.println(touchState == HIGH ? "high" : "low");
  
  if (touchState == HIGH) {
    indicate(celsius);
  }
//
//  if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)){
//    sendDataPrevMillis5 = millis();
//    void updateData(celsius);
//  }
  int i = 0;
  while (i < 50) {
    if (touchState == HIGH) {
      indicate(celsius);
    }
     delay(100);
     i = i + 1;
  }
}
