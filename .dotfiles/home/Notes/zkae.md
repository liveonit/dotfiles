# Piggato tests

1. Test toggle In/Out

Connect the Vortex XLR Output to the Apollos XRL via cable

Set in the Apollo XLR as input and SACN as output and assign to a Universe or keep the current universe.

Go to the OLA dashboard, `http://<Apollo_HOST_URL>:9090` and verify that when we change the lighting parameters in the vortex, the changes are reflected in the selected universe (in the DMX monitor section)

2. Test the `set universe` functionality

I - In the Lighticians APP (mobile) configure 2 vortex devices, each of them connected to a different universe
II - Go to Apollo lighting configurations and set one of the configured universes to sACN -> XLR and another to sACN -> CRMX.
III - Connect the Vortex XLR input to the Apollo XLR (via cable), in the phone App we have to modify the correct universe (XLR assigned universe) and the light should change when the App lighting parameters are changed, and if we change the light parameters of the universe assigned to CRMX nothing should happen
IV - Make the same as the previous step, but in this case connect the Vortex via CRMX (wireless synchronization), and in the mobile APP when we change the light parameters in the correct universe, the light should work, and nothing if we make changes in the another universe


