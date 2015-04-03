#!/usr/bin/env php

<?php

    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, "http://mm1.localdomain:8500/v1/catalog/service/app");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json'
        ]
    );

    $services = json_decode(curl_exec($ch), true);
    curl_close($ch);

    foreach ($services as $service)
    {
        preg_match('/^(.*)\..*/', $service['ServiceID'], $matches);

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, "http://" . $matches[1] . ".localdomain:8500/v1/agent/service/deregister/" . $service['ServiceID']);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
                'Content-Type: application/json'
            ]
        );

        curl_exec($ch);
        curl_close($ch);
    }
