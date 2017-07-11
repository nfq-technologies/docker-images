## XHGUI container
This container includes mongodb, php-cli and xhgui project

### Installing xhgui
Simple add this container to your project with name xhgui (or link it with other containers with xhgui name)
There is only a single port 80 that needs to be exposed: recommended value is 1081
Example:
```yaml
xhgui:
  image: docker.nfq.lt/nfqlt/xhgui
  ports:
    - "10.24.2.49:1081:80"
```
Additional to xhgui you'll need a php profiler extension enabled in your php or dev containers.
Currently only __tideways__ is supported on php versions __5.6__ and __5.3__

### Using tideways profiler and xhgui
After enabling tideways extensions a prepared php file will be included in project execution chain with php 
directive __auto_prepend_file__, but by default it will not profile anything, 
so the impact at this stage will be minimal. To actually profile application there are few ways:

 - Web requests will be profiled automatically if cookie __NFQ_PROFILER__ will be detected
 - CLI runs can be profiled with environment variable __NFQ_PROFILER__ example: `NFQ_PROFILER=1 php ./script.php`
 - Custom code blocks can be profiled by surrounding code with 
 __NfqProfiler::startProfiler()__ and __NfqProfiler::stopProfiler()__ example:

```php
public function magicMethod()
{
    NfqProfiler::startProfiler();
    $this->someHeavyAndBigLogic();
    NfqProfiler::stopProfiler();
}
```
### Custom calls to start and stop profiler
```php
/**
  * Starts tideways profiler
  *
  * @param int $flags - Flags passed to tideways_enable()*
  * @param array $options - Options passed to tideways enable()*
  * @param bool $manual - Should be true if started manually
  */
public static function startProfiler($flags = null, $options = array(), $manual = true);

/**
  * Stops profiling and send data to xhgui, also will return array containing data
  * sent to xhgui
  *
  * @param bool $shouldFlush - Should flush php buffers before stopping the profiler
  * @param bool $manual - Should be true if stopped manually
  * @return array
  */
public static function stopProfiler($shouldFlush = true, $manual = true);
```
* For optional flags and options see 
[tideways documentation](https://tideways.io/profiler/docs/setup/profiler-php-pecl-extension#documentation)

