import smtplib
import configparser
# import the corresponding modules
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

f = '/zz/zSyno/secrets/config.toml'

config = configparser.ConfigParser()
config.read(f)

port = config['attmail']['port'] 
smtp_server = config['attmail']['smtp_server']
smtp_server_ip = config['attmail']['smtp_server_ip']
login = config['attmail']['login']
print(login)
password = config['attmail']['password']
print(password)

subject = "An example of boarding pass"
sender_email = config['attmail']['sender_email'] 
receiver_email = config['attmail']['receiver_email'] 

msg = MIMEMultipart()
msg["From"] = sender_email
msg["To"] = receiver_email
msg["Subject"] = subject

# Add body to email
body = "This is an example of how you can send a boarding pass in attachment with Python"
msg.attach(MIMEText(body, "plain"))
filename = "/var/tmp/keys.tar"
# Open PDF file in binary mode
# We assume that the file is in the directory where you run your Python script from
with open(filename, "rb") as attachment:
    # The content type "application/octet-stream" means that a MIME attachment is a binary file
    part = MIMEBase("application", "octet-stream")
    part.set_payload(attachment.read())
# Encode to base64
encoders.encode_base64(part)
# Add header
part.add_header(
    "Content-Disposition",
    f"attachment; filename= {filename}",
)
# Add attachment to your message and convert it to string
msg.attach(part)
text = msg.as_string()
# send your email
with smtplib.SMTP_SSL(smtp_server_ip, port) as server:
    server.login(login, password)
    server.sendmail(
        sender_email, receiver_email, text
    )
print('Sent') 
