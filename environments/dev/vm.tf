module "test_web_server_1" {
    source = "../../modules/instance"

    name = "test-web-server-1"
    machine_type = "e2-micro"
    zone = "us-east4-a"

    boot_disk = [{
        initialize_params = [{
            image = "debian-cloud/debian-11"
        }]
    }]

    network_interface = [{
        network = "default"
    }]
    
    init_script_path = "../../init_scripts/nginx.sh"
    tags = ["http-server"]
    service_account = [
        {
            email: google_service_account.test_sa_web_server_1.email
        }
    ]
}

module "test_web_server_2" {
    source = "../../modules/instance"

    name = "test-web-server-2"
    machine_type = "e2-micro"
    zone = "us-east4-b"

    boot_disk = [{
        initialize_params = [{
            image = "debian-cloud/debian-11"
        }]
    }]

    network_interface = [{
        network = "default"
    }]
    
    init_script_path = "../../init_scripts/nginx.sh"
    tags = ["http-server"]
    service_account = [
        {
            email: google_service_account.test_sa_web_server_2.email
        }
    ]
}

module "test_web_server_group_1" {
    source = "../../modules/instance_group"

    name = "test-web-server-group-1"
    zone        = "us-east4-a"
    instances = [
        module.test_web_server_1.self_link
    ]
    named_port = [{
        name = "http"
        port = 80
    }]
}

module "test_web_server_group_2" {
    source = "../../modules/instance_group"

    name = "test-web-server-group-2"
    zone        = "us-east4-b"
    instances = [
        module.test_web_server_2.self_link
    ]
    named_port = [{
        name = "http"
        port = 80
    }]
}
