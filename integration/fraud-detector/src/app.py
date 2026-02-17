import streamlit as st
from services.blob_service import upload_blob
from services.credit_card_service import analyze_credit_card


def configure_interface():
    st.title("File Upload")
    uploaded_file = st.file_uploader("Select a file", type=["png", "jpg", "jpeg"])
    
    if uploaded_file is not None:
        fileName = uploaded_file.name
        # sent to blob storage
        blob_url = upload_blob(uploaded_file, fileName)
        if blob_url:
            st.write(f"File {fileName} sent to Azure Blob Storage")
            credit_card_info = analyze_credit_card(blob_url) # call the detection function about credit card's informations
            show_image_and_validation(blob_url, credit_card_info)
        else:
            st.write(f"Error: Not send file {fileName} to the Azure Blob Storage")

def show_image_and_validation(blob_url, credit_card_info):
    st.image(blob_url, caption="Sent Image", use_column_width=True)
    st.write("Validation Result:")
    if credit_card_info and credit_card_info["card_name"]:
        st.markdown(f"<h1 style='color: green; '>Valid Card</h1>", unsafe_allow_html=True)
        st.write(f"Owner name: {credit_card_info['card_name']}")
        st.write(f"Emitter bank: {credit_card_info['bank_name']}")
        st.write(f"Expiration Date: {credit_card_info['expiry_date']}")
    else:
        st.write(f"<h1 style='color: red; '>Invalid Card</h1>", unsafe_allow_html=True)
        st.write(f"This card is not valid.")

    
if __name__ == "__main__":
    configure_interface()