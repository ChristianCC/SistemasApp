﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.42000
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Entidades.Serv_Token {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="RespuestaSesion", Namespace="http://schemas.datacontract.org/2004/07/ViewModel")]
    [System.SerializableAttribute()]
    public partial class RespuestaSesion : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private bool ActivaField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string CodeField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string MensajeField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool Activa {
            get {
                return this.ActivaField;
            }
            set {
                if ((this.ActivaField.Equals(value) != true)) {
                    this.ActivaField = value;
                    this.RaisePropertyChanged("Activa");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Code {
            get {
                return this.CodeField;
            }
            set {
                if ((object.ReferenceEquals(this.CodeField, value) != true)) {
                    this.CodeField = value;
                    this.RaisePropertyChanged("Code");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Mensaje {
            get {
                return this.MensajeField;
            }
            set {
                if ((object.ReferenceEquals(this.MensajeField, value) != true)) {
                    this.MensajeField = value;
                    this.RaisePropertyChanged("Mensaje");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="ExceptionService", Namespace="http://schemas.datacontract.org/2004/07/ViewModel")]
    [System.SerializableAttribute()]
    public partial class ExceptionService : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ErrorCodeField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string MensajeField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string OperacionField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ErrorCode {
            get {
                return this.ErrorCodeField;
            }
            set {
                if ((object.ReferenceEquals(this.ErrorCodeField, value) != true)) {
                    this.ErrorCodeField = value;
                    this.RaisePropertyChanged("ErrorCode");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Mensaje {
            get {
                return this.MensajeField;
            }
            set {
                if ((object.ReferenceEquals(this.MensajeField, value) != true)) {
                    this.MensajeField = value;
                    this.RaisePropertyChanged("Mensaje");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Operacion {
            get {
                return this.OperacionField;
            }
            set {
                if ((object.ReferenceEquals(this.OperacionField, value) != true)) {
                    this.OperacionField = value;
                    this.RaisePropertyChanged("Operacion");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="Serv_Token.IServiceToken")]
    public interface IServiceToken {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceToken/ValidarToken", ReplyAction="http://tempuri.org/IServiceToken/ValidarTokenResponse")]
        [System.ServiceModel.FaultContractAttribute(typeof(Entidades.Serv_Token.ExceptionService), Action="http://tempuri.org/IServiceToken/ValidarTokenExceptionServiceFault", Name="ExceptionService", Namespace="http://schemas.datacontract.org/2004/07/ViewModel")]
        Entidades.Serv_Token.RespuestaSesion ValidarToken(string token);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceToken/ValidarToken", ReplyAction="http://tempuri.org/IServiceToken/ValidarTokenResponse")]
        System.Threading.Tasks.Task<Entidades.Serv_Token.RespuestaSesion> ValidarTokenAsync(string token);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceToken/ValidarAcceso", ReplyAction="http://tempuri.org/IServiceToken/ValidarAccesoResponse")]
        [System.ServiceModel.FaultContractAttribute(typeof(Entidades.Serv_Token.ExceptionService), Action="http://tempuri.org/IServiceToken/ValidarAccesoExceptionServiceFault", Name="ExceptionService", Namespace="http://schemas.datacontract.org/2004/07/ViewModel")]
        Entidades.Serv_Token.RespuestaSesion ValidarAcceso(string url, string usuario);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceToken/ValidarAcceso", ReplyAction="http://tempuri.org/IServiceToken/ValidarAccesoResponse")]
        System.Threading.Tasks.Task<Entidades.Serv_Token.RespuestaSesion> ValidarAccesoAsync(string url, string usuario);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceToken/CerrarSesion", ReplyAction="http://tempuri.org/IServiceToken/CerrarSesionResponse")]
        [System.ServiceModel.FaultContractAttribute(typeof(Entidades.Serv_Token.ExceptionService), Action="http://tempuri.org/IServiceToken/CerrarSesionExceptionServiceFault", Name="ExceptionService", Namespace="http://schemas.datacontract.org/2004/07/ViewModel")]
        void CerrarSesion(string usuario);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceToken/CerrarSesion", ReplyAction="http://tempuri.org/IServiceToken/CerrarSesionResponse")]
        System.Threading.Tasks.Task CerrarSesionAsync(string usuario);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IServiceTokenChannel : Entidades.Serv_Token.IServiceToken, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class ServiceTokenClient : System.ServiceModel.ClientBase<Entidades.Serv_Token.IServiceToken>, Entidades.Serv_Token.IServiceToken {
        
        public ServiceTokenClient() {
        }
        
        public ServiceTokenClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public ServiceTokenClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public ServiceTokenClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public ServiceTokenClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public Entidades.Serv_Token.RespuestaSesion ValidarToken(string token) {
            return base.Channel.ValidarToken(token);
        }
        
        public System.Threading.Tasks.Task<Entidades.Serv_Token.RespuestaSesion> ValidarTokenAsync(string token) {
            return base.Channel.ValidarTokenAsync(token);
        }
        
        public Entidades.Serv_Token.RespuestaSesion ValidarAcceso(string url, string usuario) {
            return base.Channel.ValidarAcceso(url, usuario);
        }
        
        public System.Threading.Tasks.Task<Entidades.Serv_Token.RespuestaSesion> ValidarAccesoAsync(string url, string usuario) {
            return base.Channel.ValidarAccesoAsync(url, usuario);
        }
        
        public void CerrarSesion(string usuario) {
            base.Channel.CerrarSesion(usuario);
        }
        
        public System.Threading.Tasks.Task CerrarSesionAsync(string usuario) {
            return base.Channel.CerrarSesionAsync(usuario);
        }
    }
}