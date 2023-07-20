# About
Simple dev container for vscode which enables developing for esp32 with matter framework.

## Dev
Open this project using vscode and then reopen it in container. It can take few hours to download and build container with all dependencies. It should also install espressif tools. In `main` there is ready example for led light. This was prepared for linux environment, if you wan't to use it on windows or mac os x check how to expose usb devices to docker container(look at the documentation in references).

## References
https://docs.espressif.com/projects/esp-idf/en/v4.4.2/esp32/get-started/index.html#step-1-install-prerequisites
https://docs.espressif.com/projects/esp-matter/en/main/esp32/developing.html#device-console
https://github.com/espressif/esp-idf-template
https://github.com/espressif/vscode-esp-idf-extension/blob/HEAD/docs/tutorial/using-docker-container.md
https://developers.home.google.com/matter/vendors/espressif


## BugFix
- use idf.py tool instead of extensions
- add CONFIG_MBEDTLS_HKDF_C=y to sdkconfig
- use idf.py set-target esp32
