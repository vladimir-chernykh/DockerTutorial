# Docker on Amazon

This tutorial explains how to deploy Docker container on the Amazon EC2 instance and how to work with it.

## Amazon

First thing to do is to set the Amazon EC2 instance. Instructions can be found in my [Amazon tutorial](./Amazon.md).

## Docker

After setting up Amazon instance you need to log in there via ssh (how to do it is also described in Amazon tutorial).
From the command line on the server do all the things described in my very detailed [Docker tutorial](./Docker.md). 

Notice that if one want to train neural networks on this instance it is highly recommended to install nvidia-docker and use gpu version of image. It gives significant speed-up.

## Putting all together

Having Amazon instance with Docker running on it the only thing left is to connect to the Jupyter Notebook running inside `vovacher/seq2seq` container. It can be easily done by means of SSH tunnel (in the same way as I did it in the Amazon tutorial for the Jupyter runnning simply on Amazon instance - it is so because Docker exposes the port from inside the container to the host and thus accessing the 8888 port of the host we actually access 8888 port of the container). You should execute the following command on your laptop

    $ ssh -i <path/to/amazon/ssh/key> -N -f -L localhost:<desired_port_at_local_machine>:localhost:8888 <user>@<server>
    
For example, if the private Amazon ssh-key is placed at `~/.ssh/amazon_key.pem`, you want to have Docker Jupyter Notebook on 9999 port on your laptop and server credentials are the following `User:ec2-user`, `Server: ec2-198-51-100-1.compute-1.amazonaws.com` then the command will look like

    $ ssh -i ~/.ssh/amazon_key.pem -N -f -L localhost:9999:localhost:8888 ec2-user@ec2-198-51-100-1.compute-1.amazonaws.com
    
And that's all! Now you should be able to access Jupyter Notebook running inside Docker container on Amazon instance by simply typing
    
    localhost:9999
    
in web-browser of your laptop.
