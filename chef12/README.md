## Node.js toolbox

### Info
This is an image of Chefdk 1.2.22 version

### Global npm packages
This image has pre-installed Chef development tools

 - Chef
 - Berkshelf
 - Test Kitchen
 - ChefSpec
 - Foodcritic
 - Delivery CLI
 - Push Jobs Client

### Configuration
Available binary paths for export:

- /usr/bin/chef
- /usr/bin/chef-solo
- /usr/bin/chef-apply
- /usr/bin/chef-client
- /usr/bin/chef-shell

### The `chef` Command

Our goal is for `chef` to become a workflow tool that builds on the
ideas of Berkshelf to provide an awesome experience that encourages
quick iteration and testing (and makes those things easy) and provides a
way to easily, reliably, and repeatably roll out new automation code to
your infrastructure.

While we've got a long way to go before we reach that goal we do have
some helpful bits of functionality already included in the `chef`
command:

#### `chef generate`
The generate subcommand generates skeleton Chef code
layouts so you can skip repetitive boilerplate and get down to
automating your infrastructure quickly. Unlike other generators, it only
generates the minimum required files when creating a cookbook so you can
focus on the task at hand without getting overwhelmed by stuff you don't
need.

The following generators are built-in:

* `chef generate app` Creates an "application" layout that supports
multiple cookbooks. This is a somewhat experimental compromise between
the one-repo-per-cookbook and monolithic-chef-repo styles of cookbook
management.

* `chef generate cookbook` Creates a single cookbook.
* `chef generate recipe` Creates a new recipe file in an existing
cookbook.
* `chef generate attribute` Creates a new attributes file in an existing
cookbook.
* `chef generate template` Creates a new template file in an existing
cookbook. Use the `-s SOURCE` option to copy a source file's content to
populate the template.
* `chef generate file` Creates a new cookbook file in an existing
cookbook. Supports the `-s SOURCE` option similar to template.
* `chef generate lwrp` Creates a new LWRP resource and provider in an
existing cookbook.

The `chef generate` command also accepts additional `--generator-arg key=value`
pairs that can be used to supply ad-hoc data to a generator cookbook.
For example, you might specify `--generator-arg database=mysql` and then only
write a template for `recipes/mysql.rb` if `context.database == 'mysql'`.

#### `chef gem`
`chef gem` is a wrapper command that manages installation and updating
of rubygems for the Ruby installation embedded in the ChefDK package.
This allows you to install knife plugins, Test Kitchen drivers, and
other Ruby applications that are not packaged with ChefDK.

Gems are installed to a `.chefdk` directory in your home directory; any
executables included with a gem you install will be created in
`~/.chefdk/gem/ruby/2.1.0/bin`. You can run these executables with
`chef exec`, or use `chef shell-init` to add ChefDK's paths to your
environment. Those commands are documented below.

### `chef exec`
`chef exec <command>` runs any arbitrary shell command with the PATH
environment variable and the ruby environment variables (`GEM_HOME`,
`GEM_PATH`, etc.) setup to point at the embedded ChefDK omnibus environment.

### `chef shell-init`
`chef shell-init SHELL_NAME` emits shell commands that modify your
environment to make ChefDK your primary ruby. It supports bash, zsh,
fish and PowerShell (posh). For more information to help you decide if
this is desirable and instructions, see "Using ChefDK as Your Primary
Development Environment" below.

### `chef install`
`chef install` reads a `Policyfile.rb` document, which contains a
`run_list` and optional cookbook version constraints, finds a set of
cookbooks that provide the desired recipes and meet dependency
constraints, and emits a `Policyfile.lock.json` describing the expanded
run list and locked cookbook set. The `Policyfile.lock.json` can be used
to install the cookbooks on another machine. The policy lock can be
uploaded to a Chef Server (via the `chef push` command) to apply the
expanded run list and locked cookbook set to nodes in your
infrastructure. See the POLICYFILE_README.md for further details.

### `chef push`
`chef push POLICY_GROUP` uploads a Policyfile.lock.json along with the cookbooks it
references to a Chef Server. The policy lock is applied to a
`POLICY_GROUP`, which is a set of nodes that share the same run list and
cookbook set. This command operates in compatibility mode and has the
same caveats as `chef install`. See the POLICYFILE_README.md for further
details.

### `chef update`
`chef update` updates a Policyfile.lock.json with the latest cookbooks
from upstream sources. It supports an `--attributes` flag which will
cause only attributes from the Policyfile.rb to be updated.

### `chef diff`
`chef diff` shows an itemized diff between Policyfile locks. It can
compare Policyfile locks from local disk, git, and/or the Chef Server,
based on the options given.

#### `chef verify`
`chef verify` tests the embedded applications. By default it runs a
quick "smoke test" to verify that the embedded applications are
installed correctly and can run basic commands. As an end user this is
probably all you'll ever need, but `verify` can also optionally run unit
and integration tests by supplying the `--unit` and `--integration`
flags, respectively.

You can also focus on a specific suite of tests by passing it as an argument.
For example `chef verify git` will only run the smoke tests for the `git` suite.

*WARNING:* The integration tests will do dangerous things like start
HTTP servers with access to your filesystem and even create users and
groups if run with sufficient privileges. The tests may also be
sensitive to your machine's configuration. If you choose to run these,
we recommend to only run them on dedicated, isolated hosts (we do this
in our build cluster to verify each build).

### Sample configuration
```
version: '2.4'
services:
  dev:
    image: nfqlt/php72-dev
    volumes:
      - './src:/home/project/src'
    volumes_from:
      - 'service:cheftools:rw'
    environment:
      NFQ_REMOTE_TOOL_CHEFTOOLS: >
        /usr/bin/chef
        /usr/bin/chef-solo
        /usr/bin/chef-apply
        /usr/bin/chef-client
        /usr/bin/chef-shell
  cheftools:
    image: nfqlt/chef12
    volumes_from:
      - './src:/home/project/src'
      - /tmp
```
