Subject: Data Model & Data Quality Issues

Hello [Stakeholder Name],

I hope you've been well. I’ve been working on the data model for the user, brand, and receipt data your team provided and wanted to share an update on my progress.

After reviewing the data, I’ve identified five key entities: User, Brand, Receipt, Receipt Item, and Metabrite Item. Please refer to the attached diagram for a detailed breakdown of these entities including relevant fields and how the entities relate to one another.

Something I wanted to discuss is potentionally breaking down the Receipt Items entity into two entities, Receipt Items and Items, to reduce the amount of redundant data in our data model. For example, fields such as competitive_product and item_number appear to be dependent solely on the item, while fields such as quantity_purchased and price_after_coupon are dependent on the item and the particular transaction that item was purchased in. This suggests that creating a separate Items entity uniquely identified by the item barcode could be beneficial. However, I’d like to get a better understanding of the data to ensure these dependencies are accurate before doing so.

Additionally, I’ve discovered a few data quality issues that I wanted to bring to your attention:

1. Missing user data: There exists many user_ids in the receipt data that don't have a match in the users data.
2. Missing brand information: There are many item barcodes on receipts that aren't present in the brands data. This can make it difficult to perform analysis on brands.
3. Discrepancies in receipt totals: The sum of individual item amounts and quantities across a particular receipt doesn't always align with the total spent and total item count at the receipt level. I would like to clarify whether this is expected or if there is an underlying issue with the data.
4. Missing values: Several fields have missing values. I’d like to review which fields, if any, should always be populated and whether there are any fields that should have default values applied when data is missing.
5. Data validation: Some fields seem to have a limited set of expected values. For example, in the users data, the sign-up source appears to only allow ‘Email’ or ‘Google.’ I’d like to confirm which fields should follow similar constraints so I can implement proper data validation.

Lastly, could you share any specific ways you’d like to slice the data? For example, it seems there’s a focus on transaction data by brand. Understanding any additional requirements will help me optimize the model for your needs.

I’d love to set up a time to go over these points in more detail so we can ensure that the data model is as accurate and efficient as possible. Please let me know when you’d be available to meet.

Thank you for your time! I'm looking forward to your feedback.

Best regards,
Helena