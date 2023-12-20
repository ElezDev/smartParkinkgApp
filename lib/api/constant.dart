const baseURL = 'http://192.168.101.8:8001/api/';


const registerURL = '${baseURL}register_user';
const userURL = '${baseURL}user_data';
const companyURL = '${baseURL}empresas';
const logoutUrl = '${baseURL}logout';
const cancelarServiceUrl = '${baseURL}cancelar_servicio';
const urlServiceByUser = '${baseURL}store-service-mobile';
const urlUpdateProfile = '${baseURL}update_profile';
const getMessageURL = '${baseURL}comments-service-movil/';
const postMessageURL = '${baseURL}store-comments-service-app-movil/';

// ----- Errors -----
const serverError = 'Eror en la respuesta';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';
