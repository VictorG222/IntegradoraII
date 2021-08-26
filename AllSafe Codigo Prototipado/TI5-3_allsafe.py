#TI5-3_AllSafe

#Se importan la librerias necesarias
import RPi.GPIO as GPIO
import time 
from pymongo import MongoClient
from datetime import datetime
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage


#Classe para el envio de datos a MongoDB
class DatabaseMongoDB:
	
		
	def insert(self, puerta):
		client = MongoClient("mongodb://admin:123654789@cluster0-shard-00-00.jdpnh.mongodb.net:27017,cluster0-shard-00-01.jdpnh.mongodb.net:27017,cluster0-shard-00-02.jdpnh.mongodb.net:27017/?ssl=true&replicaSet=atlas-4t91yj-shard-0&authSource=admin")
		db = client.allsafe
		coll = db.accesoboveda
		
		dato = {"fecha": datetime.today().strftime('%Y-%m-%d'), "hora": datetime.today().strftime('%H:%M:%S'),
				"estado": estadopul}
		coll.insert_one(dato)


GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD)

#Se declaran los elementos del circuito asi como si estos seran entradas o salidas
pul = 13
servo = 16
trig = 10
echo = 12
buzzer = 15
GPIO.setup(servo, GPIO.OUT)
GPIO.setup(trig, GPIO.OUT)
GPIO.setup(echo, GPIO.IN)
GPIO.setup(buzzer, GPIO.OUT)
GPIO.setup(pul, GPIO.IN) 


#Funcionamiento del servomotor, pulsador y sensor de distancia
p = GPIO.PWM(servo, 50) 
p.start(2.5)
estadoservo = 2.5 
p.ChangeDutyCycle(2.5)

try:
	while True:
		GPIO.output(trig,GPIO.LOW)
		time.sleep(0.5)
		GPIO.output(trig,GPIO.HIGH)
		time.sleep(0.00001)
		GPIO.output(trig,GPIO.LOW)

		inicio = time.time()
		while GPIO.input(echo)==0:
			inicio = time.time()
		
		while GPIO.input(echo)==1:
			final = time.time() 

		tiempo_transcurrido = final - inicio

		duracion = tiempo_transcurrido*34000
		distancia = duracion/2
		print(distancia)
		

		estadopul = GPIO.input(pul)
		print(estadopul)
		time.sleep(0.1)
			
		if estadopul == 1 and estadoservo == 2.5:
			p.ChangeDutyCycle(12.5) # posicion 180 grados
			estadoservo = 12.5
			DatabaseMongoDB().insert(estadopul)
			print("Boton presionado")
			time.sleep(1)
			
		elif estadopul == 1 and estadoservo == 12.5:
			p.ChangeDutyCycle(2.5)
			estadoservo = 2.5
			print("Boton presionado")
			time.sleep(1)
			
		elif distancia < 32.00 or distancia > 34.00 :
			GPIO.output(buzzer, GPIO.LOW)
			time.sleep(1)
			GPIO.output(buzzer, GPIO.HIGH)
			time.sleep(1)
			print("Puerta abierta")
			GPIO.output(buzzer, GPIO.LOW)
			time.sleep(1)
			
		elif distancia > 32.00 and distancia > 34.00:
			GPIO.output(buzzer, GPIO.LOW)
			time.sleep(1)
			
		
			
	GPIO.output(buzzer, GPIO.LOW)

			
			
except KeyboardInterrupt:
	GPIO.cleanup()
