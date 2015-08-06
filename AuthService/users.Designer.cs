﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.ComponentModel;
using System.Data.EntityClient;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Runtime.Serialization;
using System.Xml.Serialization;

[assembly: EdmSchemaAttribute()]
namespace AuthServiceLibrary
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class AuthContext : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new AuthContext object using the connection string found in the 'AuthContext' section of the application configuration file.
        /// </summary>
        public AuthContext() : base("name=AuthContext", "AuthContext")
        {
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new AuthContext object.
        /// </summary>
        public AuthContext(string connectionString) : base(connectionString, "AuthContext")
        {
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new AuthContext object.
        /// </summary>
        public AuthContext(EntityConnection connection) : base(connection, "AuthContext")
        {
            OnContextCreated();
        }
    
        #endregion
    
        #region Partial Methods
    
        partial void OnContextCreated();
    
        #endregion
    
        #region ObjectSet Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        public ObjectSet<user> users
        {
            get
            {
                if ((_users == null))
                {
                    _users = base.CreateObjectSet<user>("users");
                }
                return _users;
            }
        }
        private ObjectSet<user> _users;

        #endregion

        #region AddTo Methods
    
        /// <summary>
        /// Deprecated Method for adding a new object to the users EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddTousers(user user)
        {
            base.AddObject("users", user);
        }

        #endregion

    }

    #endregion

    #region Entities
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="usersModel", Name="user")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class user : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new user object.
        /// </summary>
        /// <param name="user_id">Initial value of the user_id property.</param>
        public static user Createuser(global::System.Int64 user_id)
        {
            user user = new user();
            user.user_id = user_id;
            return user;
        }

        #endregion

        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int64 user_id
        {
            get
            {
                return _user_id;
            }
            set
            {
                if (_user_id != value)
                {
                    Onuser_idChanging(value);
                    ReportPropertyChanging("user_id");
                    _user_id = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("user_id");
                    Onuser_idChanged();
                }
            }
        }
        private global::System.Int64 _user_id;
        partial void Onuser_idChanging(global::System.Int64 value);
        partial void Onuser_idChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String login
        {
            get
            {
                return _login;
            }
            set
            {
                OnloginChanging(value);
                ReportPropertyChanging("login");
                _login = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("login");
                OnloginChanged();
            }
        }
        private global::System.String _login;
        partial void OnloginChanging(global::System.String value);
        partial void OnloginChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String password
        {
            get
            {
                return _password;
            }
            set
            {
                OnpasswordChanging(value);
                ReportPropertyChanging("password");
                _password = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("password");
                OnpasswordChanged();
            }
        }
        private global::System.String _password;
        partial void OnpasswordChanging(global::System.String value);
        partial void OnpasswordChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public Nullable<global::System.Int32> age
        {
            get
            {
                return _age;
            }
            set
            {
                OnageChanging(value);
                ReportPropertyChanging("age");
                _age = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("age");
                OnageChanged();
            }
        }
        private Nullable<global::System.Int32> _age;
        partial void OnageChanging(Nullable<global::System.Int32> value);
        partial void OnageChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String email
        {
            get
            {
                return _email;
            }
            set
            {
                OnemailChanging(value);
                ReportPropertyChanging("email");
                _email = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("email");
                OnemailChanged();
            }
        }
        private global::System.String _email;
        partial void OnemailChanging(global::System.String value);
        partial void OnemailChanged();

        #endregion

    
    }

    #endregion

    
}