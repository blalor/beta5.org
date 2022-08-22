FROM public.ecr.aws/lambda/python:2.7

RUN yum install -y git python27-pip libcurl-devel gcc python27-devel
RUN pip install -U pip wheel scikit-build

COPY . /src
RUN pip install --target "${LAMBDA_TASK_ROOT}" /src

COPY thumbor.conf /var/task/image_handler/thumbor.conf

CMD [ "image_handler/lambda_function.lambda_handler" ]
