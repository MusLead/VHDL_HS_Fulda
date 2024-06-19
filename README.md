# VHDL_1515659

Please when creating a file, save the VHDL files (.vhd) separately from the project file to reduce failure parsing xml and simulating from different version, when the project is being cloned or being copied in another computer. Try to create Vivado project and add files to the project. 

DO NOT EVER COPY THE SRC FILE INTO PROJECT FILE. LET THE PROJECT FILE ACCESS THE SOURCE FROM EXTERNAL PATH (NOT FORM WITHIN ITS PROJECT FOLDER)

The vivado project should acces the data outside from the project folder. The vivado project itself should not be uploaded into git.
