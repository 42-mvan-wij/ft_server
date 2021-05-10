<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpress' );

/** MySQL database password */
define( 'DB_PASSWORD', '__DB_PASSWORD__' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '-5[fLVf,u^-pq7u1Q0.4pra,.+WS07HyJ-T0%DG9-2Z81$|+-lGQ~|3W=i2r:.4O' );
define( 'SECURE_AUTH_KEY',  '`QKl>6 =S6wj{.>,!&Y^| 8]rn1)G[mCLGO4|n5EVP%?=,v>YHjq:t27_%rStVVd' );
define( 'LOGGED_IN_KEY',    '&W|q9h,/.,M8M9h,BZHek<bv{HVf;1i#{%=qPkd@9|Rj>yTcLeK.:CA7k+Cx Tn@' );
define( 'NONCE_KEY',        '$<EkD%67xSwtVObUlnAN+,h#IU:X PEXijm8Kh1$jLpl/UJ(^.SPD*BnASQ;iRnb' );
define( 'AUTH_SALT',        'b}X;vh)?*E~?_@*H~i,!b1Y)Gv:wHlbJIgC9(-aBZ0^NEi@y2b6&V|alhBTQj}zD' );
define( 'SECURE_AUTH_SALT', 'N<sc3$+`iFO3::q@_!<@9aMe0`vR8VD;B{c%9 2,8QXIrX_.%A@Vbn>rWnSS-Td_' );
define( 'LOGGED_IN_SALT',   ':w0xGg#rb|owtV2[BCLU^YhIF~lN,Rgz@Y808|heQVA+WQgT88hQ)g$2(l>hCy~X' );
define( 'NONCE_SALT',       '-t~9c{f4B#buTDYma%rI`SST2^j@2F)8Kw0Qhz6i$,iKAgda/nHpI7X>79A_leV+' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
