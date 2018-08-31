#!/bin/bash

# Create extension
#
# usage: ynh_psql_create_extension db extension
# | arg: db - the database name where the extension will be created
# | arg: extension - the extension name to create
ynh_psql_create_extension() {
	local db="$1"
	local extension="$2"
	sudo --login --user=postgres psql -d ${db} -c "CREATE EXTENSION ${extension};"
}

# Replace variable umap conf file
#
ynh_replace_config_umap() {
	if test -n "${admin:-}"; then
		ynh_substitute_char "You" "$admin" "$localfile"
		ynh_substitute_char "your@email" "$admin@$domain" "$localfile"
	fi
	if test -n "${secret:-}"; then
		ynh_substitute_char "SECRET_KEY = '!!change me!!'" "SECRET_KEY = '$secret'" "$localfile"
	fi
	if test -n "${final_path:-}"; then
		ynh_substitute_char "STATIC_ROOT = '/home/srv/var/static'" "STATIC_ROOT = '$final_path/static'" "$localfile"
		ynh_substitute_char "MEDIA_ROOT = '/home/srv/umap/var/data'" "MEDIA_ROOT = '$final_path/data'" "$localfile"
	fi
	if test -n "${language:-}"; then
		ynh_substitute_char "LANGUAGE_CODE = 'en'" "LANGUAGE_CODE = '$language'" "$localfile"
	fi
	ynh_substitute_char "UMAP_DEMO_SITE = True" "UMAP_DEMO_SITE = False" "$localfile"

	# Replace variable for Oauth providers
	if test -n "${github_key:-}"; then
		ynh_substitute_char "SOCIAL_AUTH_GITHUB_KEY = 'xxx'" "SOCIAL_AUTH_GITHUB_KEY = '$github_key'" "$localfile"
	fi
	if test -n "${github_secret:-}"; then
		ynh_substitute_char "SOCIAL_AUTH_GITHUB_SECRET = 'xxx'" "SOCIAL_AUTH_GITHUB_SECRET = '$github_secret'" "$localfile"
	fi
	if test -n "${github_scope:-}"; then
		ynh_substitute_char "SOCIAL_AUTH_GITHUB_SCOPE = [\"user:email\", ]" "SOCIAL_AUTH_GITHUB_SCOPE = $github_scope" "$localfile"
	fi

	if test -n "${bitbucket_key:-}"; then
		ynh_substitute_char "SOCIAL_AUTH_BITBUCKET_KEY = 'xxx'" "SOCIAL_AUTH_BITBUCKET_KEY = '$bitbucket_key'" "$localfile"
	fi
	if test -n "${bitbucket_secret:-}"; then
		ynh_substitute_char "SOCIAL_AUTH_BITBUCKET_SECRET = 'xxx'" "SOCIAL_AUTH_BITBUCKET_SECRET = '$bitbucket_secret'" "$localfile"
	fi

	if test -n "${twitter_key:-}"; then
		ynh_substitute_char "SOCIAL_AUTH_TWITTER_KEY = 'xxx'" "SOCIAL_AUTH_TWITTER_KEY = '$twitter_key'" "$localfile"
	fi
	if test -n "${twitter_secret:-}"; then
		ynh_substitute_char "SOCIAL_AUTH_TWITTER_SECRET = 'xxx'" "SOCIAL_AUTH_TWITTER_SECRET = '$twitter_secret'" "$localfile"
	fi

	if test -n "${openstreetmap_key:-}"; then
		ynh_substitute_char "SOCIAL_AUTH_OPENSTREETMAP_KEY = 'xxx'" "SOCIAL_AUTH_OPENSTREETMAP_KEY = '$openstreetmap_key'" "$localfile"
	fi
	if test -n "${openstreetmap_secret:-}"; then
		ynh_substitute_char "SOCIAL_AUTH_OPENSTREETMAP_SECRET = 'xxx'" "SOCIAL_AUTH_OPENSTREETMAP_SECRET = '$openstreetmap_secret'" "$localfile"
	fi
}
