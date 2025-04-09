
redis_cache: redis-server config/redis_cache.conf
redis_queue: redis-server config/redis_queue.conf


web: bench serve  --port 8000


socketio: /Users/fongfan999/.local/share/mise/installs/node/23.11.0/bin/node apps/frappe/socketio.js


watch: bench watch


schedule: bench schedule

worker: OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES NO_PROXY=* bench worker 1>> logs/worker.log 2>> logs/worker.error.log

