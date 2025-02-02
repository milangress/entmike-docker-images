#!/bin/bash
echo "Container Started"

export DISCOART_REMOTE_MODELS_URL='https://www.feverdreams.app/models.yaml'

wget -O ../models.yaml https://www.feverdreams.app/models.yaml
echo "Downloaded models.yaml"

cd /discoart-ui
yarn start
echo "Start Disco UI"

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
    echo "SSH Service Started"
fi

if [[ $JUPYTER_PASSWORD = START ]]
then
    ln -sf /examples /workspace
    ln -sf /root/welcome.ipynb /workspace
    pip install discoart --upgrade
    
    cd /
    jupyter lab --allow-root --no-browser --port=8888 --ip=* \
        --ServerApp.terminado_settings='{"shell_command":["/bin/bash"]}' \
        --ServerApp.token=$JUPYTER_PASSWORD --ServerApp.allow_origin=* --ServerApp.preferred_dir=/workspace
    echo "Jupyter Lab Started"
else
    sleep infinity
fi
