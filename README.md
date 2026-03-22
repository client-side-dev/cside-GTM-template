# Cside Client-Side Security — Google Tag Manager Template

This is a Google Tag Manager (GTM) Community Template that injects the [cside](https://cside.com) monitoring script onto your website. Cside monitors third-party scripts running on your site and detects malicious behavior in real time.

## How it works

The template uses GTM's `injectScript` API to load the cside monitoring script from `https://proxy.csidetm.com/script.js`. No configuration is required — simply add the tag and publish your container.

## Required permissions

- **Inject Scripts**: Allows loading scripts from `https://proxy.csidetm.com/*`

## Setup

1. In Google Tag Manager, go to **Templates** > **Search Gallery**.
2. Search for **Cside Client-Side Security** and add it.
3. Create a new tag using the template.
4. Set the trigger (typically **All Pages**).
5. Preview, test, and publish.

## Resources

- [cside website](https://cside.com)
- [cside documentation](https://docs.cside.com)
