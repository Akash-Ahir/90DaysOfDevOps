#taking base image of python 
FROM python:3.14
#set up the working directory
WORKDIR /app
#copy everything from src to dest(cont)
COPY . .
#executing the command 
RUN pip install --upgrade pip
RUN pip install -r requirements.txt 
#Arguments 
CMD ["python","main.py"]
#instruction to expose the app on 8000
EXPOSE 8000
