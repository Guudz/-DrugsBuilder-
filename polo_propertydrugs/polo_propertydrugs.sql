CREATE TABLE `polo_drugsinterior` (

  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `recolteweed_menu` varchar(255) DEFAULT NULL,
  `traitementweed_menu` varchar(255) DEFAULT NULL,
  `venteweed_menu` varchar(255) DEFAULT NULL,
  `recoltecoke_menu` varchar(255) DEFAULT NULL,
  `traitementcoke_menu` varchar(255) DEFAULT NULL,
  `ventecoke_menu` varchar(255) DEFAULT NULL,
  `recoltemeth_menu` varchar(255) DEFAULT NULL,
  `traitementmeth_menu` varchar(255) DEFAULT NULL,
  `ventemeth_menu` varchar(255) DEFAULT NULL,
  `recoltecannabis_menu` varchar(255) DEFAULT NULL,
  `traitementcannabis_menu` varchar(255) DEFAULT NULL,
  `ventecannabis_menu` varchar(255) DEFAULT NULL,
  `recoltecrack_menu` varchar(255) DEFAULT NULL,
  `traitementcrack_menu` varchar(255) DEFAULT NULL,
  `ventecrack_menu` varchar(255) DEFAULT NULL,
  `recolteecstasy_menu` varchar(255) DEFAULT NULL,
  `traitementecstasy_menu` varchar(255) DEFAULT NULL,
  `venteecstasy_menu` varchar(255) DEFAULT NULL,
  `recolteheroine_menu` varchar(255) DEFAULT NULL,
  `traitementheroine_menu` varchar(255) DEFAULT NULL,
  `venteheroine_menu` varchar(255) DEFAULT NULL,
  `recolteghb_menu` varchar(255) DEFAULT NULL,
  `traitementghb_menu` varchar(255) DEFAULT NULL,
  `venteghb_menu` varchar(255) DEFAULT NULL,
  `recoltepsychedeliques_menu` varchar(255) DEFAULT NULL,
  `traitementpsychedeliques_menu` varchar(255) DEFAULT NULL,
  `ventepsychedeliques_menu` varchar(255) DEFAULT NULL,
  `recolteopium_menu` varchar(255) DEFAULT NULL,
  `traitementopium_menu` varchar(255) DEFAULT NULL,
  `venteopium_menu` varchar(255) DEFAULT NULL,
  `recolteketamine_menu` varchar(255) DEFAULT NULL,
  `traitementketamine_menu` varchar(255) DEFAULT NULL,
  `venteketamine_menu` varchar(255) DEFAULT NULL,
  `recoltelsd_menu` varchar(255) DEFAULT NULL,
  `traitementlsd_menu` varchar(255) DEFAULT NULL,
  `ventelsd_menu` varchar(255) DEFAULT NULL,
  `recoltemorphine_menu` varchar(255) DEFAULT NULL,
  `traitementmorphine_menu` varchar(255) DEFAULT NULL,
  `ventemorphine_menu` varchar(255) DEFAULT NULL,
  `recoltelean_menu` varchar(255) DEFAULT NULL,
  `traitementlean_menu` varchar(255) DEFAULT NULL,
  `ventelean_menu` varchar(255) DEFAULT NULL,
  `recolteamphetamines_menu` varchar(255) DEFAULT NULL,
  `traitementamphetamines_menu` varchar(255) DEFAULT NULL,
  `venteamphetamines_menu` varchar(255) DEFAULT NULL,
  `recoltemarijuana_menu` varchar(255) DEFAULT NULL,
  `traitementmarijuana_menu` varchar(255) DEFAULT NULL,
  `ventemarijuana_menu` varchar(255) DEFAULT NULL,
  `recoltespeed_menu` varchar(255) DEFAULT NULL,
  `traitementspeed_menu` varchar(255) DEFAULT NULL,
  `ventespeed_menu` varchar(255) DEFAULT NULL,
  `recoltethc_menu` varchar(255) DEFAULT NULL,
  `traitementthc_menu` varchar(255) DEFAULT NULL,
  `ventethc_menu` varchar(255) DEFAULT NULL,
  `blanchiment_menu` varchar(255) DEFAULT NULL,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `polo_drugswithouinterior` (

  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `recolteweed_menu` varchar(255) DEFAULT NULL,
  `traitementweed_menu` varchar(255) DEFAULT NULL,
  `venteweed_menu` varchar(255) DEFAULT NULL,
  `recoltecoke_menu` varchar(255) DEFAULT NULL,
  `traitementcoke_menu` varchar(255) DEFAULT NULL,
  `ventecoke_menu` varchar(255) DEFAULT NULL,
  `recoltemeth_menu` varchar(255) DEFAULT NULL,
  `traitementmeth_menu` varchar(255) DEFAULT NULL,
  `ventemeth_menu` varchar(255) DEFAULT NULL,
  `recoltecannabis_menu` varchar(255) DEFAULT NULL,
  `traitementcannabis_menu` varchar(255) DEFAULT NULL,
  `ventecannabis_menu` varchar(255) DEFAULT NULL,
  `recoltecrack_menu` varchar(255) DEFAULT NULL,
  `traitementcrack_menu` varchar(255) DEFAULT NULL,
  `ventecrack_menu` varchar(255) DEFAULT NULL,
  `recolteecstasy_menu` varchar(255) DEFAULT NULL,
  `traitementecstasy_menu` varchar(255) DEFAULT NULL,
  `venteecstasy_menu` varchar(255) DEFAULT NULL,
  `recolteheroine_menu` varchar(255) DEFAULT NULL,
  `traitementheroine_menu` varchar(255) DEFAULT NULL,
  `venteheroine_menu` varchar(255) DEFAULT NULL,
  `recolteghb_menu` varchar(255) DEFAULT NULL,
  `traitementghb_menu` varchar(255) DEFAULT NULL,
  `venteghb_menu` varchar(255) DEFAULT NULL,
  `recoltepsychedeliques_menu` varchar(255) DEFAULT NULL,
  `traitementpsychedeliques_menu` varchar(255) DEFAULT NULL,
  `ventepsychedeliques_menu` varchar(255) DEFAULT NULL,
  `recolteopium_menu` varchar(255) DEFAULT NULL,
  `traitementopium_menu` varchar(255) DEFAULT NULL,
  `venteopium_menu` varchar(255) DEFAULT NULL,
  `recolteketamine_menu` varchar(255) DEFAULT NULL,
  `traitementketamine_menu` varchar(255) DEFAULT NULL,
  `venteketamine_menu` varchar(255) DEFAULT NULL,
  `recoltelsd_menu` varchar(255) DEFAULT NULL,
  `traitementlsd_menu` varchar(255) DEFAULT NULL,
  `ventelsd_menu` varchar(255) DEFAULT NULL,
  `recoltemorphine_menu` varchar(255) DEFAULT NULL,
  `traitementmorphine_menu` varchar(255) DEFAULT NULL,
  `ventemorphine_menu` varchar(255) DEFAULT NULL,
  `recoltelean_menu` varchar(255) DEFAULT NULL,
  `traitementlean_menu` varchar(255) DEFAULT NULL,
  `ventelean_menu` varchar(255) DEFAULT NULL,
  `recolteamphetamines_menu` varchar(255) DEFAULT NULL,
  `traitementamphetamines_menu` varchar(255) DEFAULT NULL,
  `venteamphetamines_menu` varchar(255) DEFAULT NULL,
  `recoltemarijuana_menu` varchar(255) DEFAULT NULL,
  `traitementmarijuana_menu` varchar(255) DEFAULT NULL,
  `ventemarijuana_menu` varchar(255) DEFAULT NULL,
  `recoltespeed_menu` varchar(255) DEFAULT NULL,
  `traitementspeed_menu` varchar(255) DEFAULT NULL,
  `ventespeed_menu` varchar(255) DEFAULT NULL,
  `recoltethc_menu` varchar(255) DEFAULT NULL,
  `traitementthc_menu` varchar(255) DEFAULT NULL,
  `ventethc_menu` varchar(255) DEFAULT NULL,
  `blanchiment_menu` varchar(255) DEFAULT NULL,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;