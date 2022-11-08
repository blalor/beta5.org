FROM public.ecr.aws/lambda/python:2.7

RUN yum install -y git python27-pip libcurl-devel gcc python27-devel

COPY build-requirements.txt .
RUN pip install -r build-requirements.txt

COPY requirements.txt .
RUN pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

COPY thumbor.conf /var/task/image_handler/thumbor.conf

CMD [ "image_handler/lambda_function.lambda_handler" ]
