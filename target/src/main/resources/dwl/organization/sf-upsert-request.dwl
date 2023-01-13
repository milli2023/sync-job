%dw 2.0
output application/json
import java!java::lang::System
fun getStreet(address1, address2)  = 
	if(!isBlank(address2)) 
		(address1 as String) ++ System::lineSeparator() ++ (address2 as String)
	else 
		address1
		
var sourceSystem = vars.sourceSystem
---
payload map ( payload01 , indexOfPayload01 ) -> {
	Id: payload01.accountId,
	OwnerId: Mule::p('ids.accountowner.' ++ (sourceSystem default '')),
	Name: payload01.accountName,
	ParentId: payload01.parentAccountId,
	This_is_HQ__c: if(isBlank(payload01.parentAccountId)) true else false,
	Status__c: payload01.status,
	ccrz__E_AccountGroup__c: Mule::p('ids.accountgroup'),
	Phone: payload01.phoneNumber,
	Extension__c: payload01.phoneExtension,
	PHSS_Channel__c: payload01.phssChannel, 
	SABA_Org_Type__c: payload01.organizationType, 
	BillingStreet: getStreet(payload01.billingAddress.addressLine1, payload01.billingAddress.addressLine2), 
	BillingCity: payload01.billingAddress.city,
	BillingState: payload01.billingAddress.state,
	BillingPostalCode: payload01.billingAddress.zip,
	BillingCountry: payload01.billingAddress.country,
	Billing_Contact__c: payload01.billingContact, 
	Billing_Contact_email__c: payload01.billingContactEmail, 
	Billing_Contact_phone__c: payload01.billingContactPhone, 
	ShippingStreet: getStreet(payload01.shippingAddress.addressLine1, payload01.shippingAddress.addressLine2), 
	ShippingCity: payload01.shippingAddress.city, 
	ShippingState: payload01.shippingAddress.state, 
	ShippingPostalCode: payload01.shippingAddress.zip, 
	ShippingCountry: payload01.shippingAddress.country, 
	RecordTypeId : Mule::p('ids.recordtype.organization'), 
	Credit_Limit__c : payload01.creditLimit, 
	(if(isBlank(payload01.accountId)) { 
		Preferred_Payment_type__c: Mule::p('default.preferred.payment.type')
	} else {}),	  
	Payment_Status__c: payload01.paymentStatus,  
	Payment_Terms__c: payload01.paymentTerms,  
	Tax_Exempt__c: payload01.taxExempt,  
	Tax_ID_Number__c: payload01.taxIdNumber,  
	Invoice_Delivery_Type__c: payload01.invoiceDeliveryMethod,  
	Invoice_delivery_Email__c: payload01.invoiceDeliveryEmail,  
	Invoice_Template__c: payload01.invoiceTemplate,  
	Customer_PO_Required_on_Invoice__c: payload01.customerPORequiredOnInvoice,  
	Restrict_Order_Confirmation_Email__c: payload01.restrictOrderConfirmationEmailDistribution,  
	Invoice_Delivery_Frequency__c: payload01.invoiceDeliveryFrequency,  
	Separate_Invoice_For_Products__c: payload01.separateInvoiceForProducts,  
	Consolidate_Period_Fulfillments__c: payload01.consolidateTransactions,  
	Include_Roster__c: payload01.includeRoster  

}