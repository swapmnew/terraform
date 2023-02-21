resource "openstack_blockstorage_volume_v2" "example_volume" {
  name        = "example_volume"
  size        = "${var.volume_size}" 
  #image_id    = "${var.image_id}"
  volume_type = "${var.volume_type}"
  #availability_zone = "${var.availability_zone}"
}

resource "openstack_compute_instance_v2" "example_instance" {
  name      = "example_instance"
  image_id  = "${var.image_id}"
  flavor_id = "${var.flavor_id}"
  key_pair  = "cloud"

  network {
    name = "${var.network_name}"
  }
}

resource "openstack_compute_volume_attach_v2" "attached" {
   instance_id = "${openstack_compute_instance_v2.example_instance.id}"
   volume_id   = "${openstack_blockstorage_volume_v2.example_volume.id}"
}


resource "openstack_compute_floatingip_associate_v2" "my_pool" {
  floating_ip = var.floating_ip_address
  instance_id = "${openstack_compute_instance_v2.example_instance.id}"

  provisioner "file" {
    source      = "/tmp/sub_tasks/"
    destination = "/tmp/"
  }
  provisioner "local-exec" {
   command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u cloud-user -i '10.109.30.230,' --private-key /tmp/sub_tasks/cloud.pem -e 'pub_key=/tmp/sub_tasks/cloud.pem' main.yml"
  }
  connection {
   type        = "ssh"
   host        = "10.109.30.230"
   user        = "cloud-user"
   private_key = file("/u02/terraform/anssible-scripts/cloud.pem")
   timeout     = "4m"
  }

}

