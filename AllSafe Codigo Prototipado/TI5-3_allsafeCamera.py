#TI5-3_AllSafe

#	A CAUSA DE QUE LA CAMARA REQUIERE MUCHOS RECURSOS SE TUVO QUE OPTAR
#	POR SEPARAR EL FUNCIONAMIENTO DE ESTA EN UN CODIGO INFEPENDIENTE
#	QUE ES EJECUTADO PRIMERO

#Se importan la librerias necesarias
import RPi.GPIO as GPIO
import time 
from pymongo import MongoClient
from datetime import datetime
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from picamera import PiCamera

#Classe para el envio de datos a MongoDB
class DatabaseMongoDB:
	def insert(self, alerta):
		client = MongoClient("mongodb://admin:123654789@cluster0-shard-00-00.jdpnh.mongodb.net:27017,cluster0-shard-00-01.jdpnh.mongodb.net:27017,cluster0-shard-00-02.jdpnh.mongodb.net:27017/?ssl=true&replicaSet=atlas-4t91yj-shard-0&authSource=admin")
		db = client.allsafe
		coll = db.movimiento
		
		dato = {"fecha": datetime.today().strftime('%Y-%m-%d'), "hora": datetime.today().strftime('%H:%M:%S'),
				"alerta": estadopir}
		coll.insert_one(dato)
		
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD)


#Se declaran los elementos del circuito asi como si estos seran entradas o salidas
pir = 11
GPIO.setup(pir, GPIO.IN)

#Informacion para el envio de coreo
correo_envia = 'allsafe.notificaciones@gmail.com'
contraseña = 'sonata27'
correo_recibe = 'victorgalvan2000@gmail.com'


P = PiCamera()
P.resolution = (1024,768)
P.start_preview() 


#Clase creada para el envio de correos
def enviar_correo(estadopir):
	msg = MIMEMultipart()
	msg['Subject'] = 'Monitoreo de Presencia con imagen nuevo'
	msg['From'] = correo_envia
	msg['To'] = correo_recibe
	
	msgText = MIMEText(f"Se ha detectado movimiento fuera de lo normal el dia: {datetime.today().strftime('%d/%m/%Y')} a las {datetime.today().strftime('%H:%M:%S')}")
	msg.attach(msgText)
	
	fp = open('movimiento.jpg', 'rb')
	img = MIMEImage(fp.read())
	fp.close()
	msg.attach(img)
	
	server = smtplib.SMTP('smtp.gmail.com', 587)
	server.starttls()
	server.login(correo_envia, contraseña)
	server.sendmail(correo_envia, correo_recibe, msg.as_string())
	server.send_message(msg)
	print('Correo enviado')
	server.quit()

#Funcionamiento de la camara	
try:
	while True:
		estadopir = GPIO.input(pir)
		
		
		if estadopir == 1 :
			P.capture('movimiento.jpg')
			time.sleep(2)
			enviar_correo(estadopir)
			DatabaseMongoDB().insert(estadopir)
			print("Movimiento detectado")
		elif estadopir ==0 :
			time.sleep(1)
		
			
except KeyboardInterrupt:
	GPIO.cleanup()
