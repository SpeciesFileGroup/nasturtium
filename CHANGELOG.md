## [Unreleased]

## [0.1.2] - 2026-06-17
 - Allow Ruby 4.0.0:
    - Relaxed `required_ruby_version` to `>= 2.5.0, < 5.0`
    - Added Ruby 4.0.0 to the CI matrix
    - Bumped `faraday-follow_redirects` upper bound to allow 0.5+ (which lifts the Ruby < 4 cap)
    - Dropped the `bundler` development dependency
 - Fixed `elseif` typo in `Faraday::NasturtiumErrors` middleware that crashed error parsing on non-message error bodies; hardened `error_body` against unexpected shapes
 - Updated tests to match current iNaturalist API responses (taxonomy drift, fuzzy autocomplete, post-endpoint 404s on empty projects)
 - Updated license from NCSA to MIT

## [0.1.1] - 2024-09-11
 - Removed Gemfile.lock
 - Bumped development depency versions to avoid CVE-2024-43398

## [0.1.0] - 2022-01-20

- Initial release
