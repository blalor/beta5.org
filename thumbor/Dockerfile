FROM public.ecr.aws/lambda/python:3.9

RUN yum install -y git

COPY requirements.txt .
RUN pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

COPY thumbor.conf /var/task/image_handler/thumbor.conf

CMD [ "image_handler/lambda_function.lambda_handler" ]
