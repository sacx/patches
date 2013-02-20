--- vsphere_vm_clone.rb	2013-02-20 21:57:38.204080139 +0200
+++ vsphere_vm_clone_nocustomization.rb	2013-02-20 22:00:23.247082756 +0200
@@ -158,6 +158,10 @@
 		:long => "--no-host-key-verify",
 		:description => "Disable host key verification",
 		:boolean => true
+	option :no_customization,
+		:long => "--no-customization",
+		:description => "Disable default customization",
+		:boolean => false
 
 	def run
 		$stdout.sync = true
@@ -231,9 +235,7 @@
 			rspec.datastore = find_datastore(get_config(:datastore))
 		end
 
-		clone_spec = RbVmomi::VIM.VirtualMachineCloneSpec(:location => rspec,
-																											:powerOn => false,
-																											:template => false)
+		clone_spec = RbVmomi::VIM.VirtualMachineCloneSpec(:location => rspec,:powerOn => false,:template => false)
 
 		clone_spec.config = RbVmomi::VIM.VirtualMachineConfigSpec(:deviceChange => Array.new)
 
@@ -289,6 +291,7 @@
 			end
 		end
 
+		if get_config(:no_customization)
 		use_ident = !config[:customization_hostname].nil? || !get_config(:customization_domain).nil? || cust_spec.identity.nil?
 
 		if use_ident
@@ -312,6 +315,8 @@
 		end
 
 		clone_spec.customization = cust_spec
+		end
+		
 		clone_spec
 	end
 
