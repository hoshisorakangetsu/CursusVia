﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CursusVia
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class CursusViaEntities2 : DbContext
    {
 
        public CursusViaEntities2() : base("name=CursusViaEntities2")
        {
        }

        public virtual DbSet<Models.Admin> Admins { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Models.Admin>().ToTable("Admins"); 
            base.OnModelCreating(modelBuilder);
        }

    }
}
