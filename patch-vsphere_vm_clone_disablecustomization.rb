--- vsphere_vm_clone.rb	2013-02-20 23:51:57.534726802 +0200
+++ vsphere_vm_clone_disablecustomization.rb	2013-02-20 23:52:24.781874436 +0200
@@ -159,6 +159,12 @@
 		:description => "Disable host key verification",
 		:boolean => true
 
+	option :disable_customization,
+		:long => "--disable-customization",
+		:description => "Disable default customization",
+		:boolean => true,
+		:default => false
+
 	def run
 		$stdout.sync = true
 
@@ -231,9 +237,7 @@
 			rspec.datastore = find_datastore(get_config(:datastore))
 		end
 
-		clone_spec = RbVmomi::VIM.VirtualMachineCloneSpec(:location => rspec,
-																											:powerOn => false,
-																											:template => false)
+		clone_spec = RbVmomi::VIM.VirtualMachineCloneSpec(:location => rspec,:powerOn => false,:template => false)
 
 		clone_spec.config = RbVmomi::VIM.VirtualMachineConfigSpec(:deviceChange => Array.new)
 
@@ -289,6 +293,7 @@
 			end
 		end
 
+		if !get_config(:disable_customization)
 		use_ident = !config[:customization_hostname].nil? || !get_config(:customization_domain).nil? || cust_spec.identity.nil?
 
 		if use_ident
@@ -312,6 +317,8 @@
 		end
 
 		clone_spec.customization = cust_spec
+		end
+		
 		clone_spec
 	end
 
