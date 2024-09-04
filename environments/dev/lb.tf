
module "lb" {
    source = "../../modules/lb"

    name = "test-nginx"
    backend = [
        {
            group: module.test_web_server_group_1.id,
        },
        {
            group: module.test_web_server_group_2.id
        }
    ]
}
